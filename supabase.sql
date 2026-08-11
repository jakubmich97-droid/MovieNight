-- MovieNight – Supabase schema v1
-- Spusťte celý skript v Supabase → SQL Editor → New query.
create extension if not exists pgcrypto;
create table if not exists public.titles (
  id uuid primary key default gen_random_uuid(),
  type text not null check (type in ('movie','series')),
  title text not null check (char_length(title) between 1 and 120),
  genre text not null,
  genre_secondary text,
  year integer check (year between 1888 and 2100),
  runtime integer check (runtime is null or runtime > 0),
  seasons integer check (seasons is null or seasons > 0),
  platform text not null default '',
  status text not null default 'planned' check (status in ('planned','watching','finished')),
  note text not null default '' check (char_length(note) <= 400),
  seen_kuba boolean not null default false,
  seen_partner boolean not null default false,
  favorite boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint correct_media_fields check ((type = 'movie' and seasons is null) or (type = 'series' and runtime is null))
);
-- Bezpečná migrace pro projekty, kde už byla spuštěna verze 1.
alter table public.titles add column if not exists genre_secondary text;
create index if not exists titles_type_idx on public.titles(type);
create index if not exists titles_genre_idx on public.titles(genre);
create index if not exists titles_created_at_idx on public.titles(created_at desc);
create or replace function public.set_updated_at() returns trigger language plpgsql security invoker set search_path = public as $$
begin new.updated_at = now(); return new; end; $$;
drop trigger if exists titles_set_updated_at on public.titles;
create trigger titles_set_updated_at before update on public.titles for each row execute function public.set_updated_at();
alter table public.titles enable row level security;
drop policy if exists "MovieNight read" on public.titles;
drop policy if exists "MovieNight insert" on public.titles;
drop policy if exists "MovieNight update" on public.titles;
drop policy if exists "MovieNight delete" on public.titles;
create policy "MovieNight read" on public.titles for select to anon, authenticated using (true);
create policy "MovieNight insert" on public.titles for insert to anon, authenticated with check (true);
create policy "MovieNight update" on public.titles for update to anon, authenticated using (true) with check (true);
create policy "MovieNight delete" on public.titles for delete to anon, authenticated using (true);
grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on public.titles to anon, authenticated;
do $$ begin alter publication supabase_realtime add table public.titles; exception when duplicate_object then null; end $$;

# MovieNight

Společná mobilní webová aplikace pro Kubu a přítelkyni: seznam filmů i seriálů, informace o tom, kdo titul viděl, filtry a náhodné losování na večer.

## Funkce první produkční verze

- oddělené seznamy Filmy a Seriály
- přidávání a mazání titulů
- žánr, rok, délka filmu, počet řad, platforma a poznámka
- samostatné označení „viděl Kuba“ a „viděla přítelkyně“
- oblíbené tituly a stav plánováno / rozkoukáno / dokoukáno
- hledání, filtrování a losování
- responzivní rozhraní pro telefon
- Supabase synchronizace v reálném čase
- lokální režim, dokud není Supabase nakonfigurované

## Zapojení Supabase

1. Vytvoř nový projekt na Supabase.
2. V SQL Editoru spusť celý soubor supabase.sql.
3. V Project Settings → API zkopíruj Project URL a veřejný anon/publishable key.
4. Doplň obě hodnoty do config.js.
5. Commitni změnu do větve main.

Anon key je určený pro frontend. Nikdy sem nevkládej service_role key.

## Omezení verze bez přihlášení

Databázová pravidla dovolují návštěvníkům aplikace seznam číst a upravovat. Aplikaci zatím nesdílej veřejně mimo vás dva. Později lze přidat společný PIN nebo dva účty.

## Nasazení

Workflow v .github/workflows/pages.yml publikuje větev main na GitHub Pages. V nastavení repozitáře případně jednorázově vyber Settings → Pages → Source: GitHub Actions.

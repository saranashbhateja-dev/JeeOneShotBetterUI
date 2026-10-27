-- JEE OneShot OS 4.0.0
-- The app uses the public publishable key and requires a signed-in user for cloud sync.
-- Local browser/device saves keep working without signing in or while offline.

create table if not exists public.jee_one_shot_os_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  client_updated_at timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  constraint jee_one_shot_os_state_object check (jsonb_typeof(state) = 'object')
);

create or replace function public.jee_one_shot_os_set_server_updated_at()
returns trigger
language plpgsql
set search_path = pg_catalog, public
as $$
begin
  new.server_updated_at = now();
  return new;
end;
$$;

drop trigger if exists jee_one_shot_os_updated_at on public.jee_one_shot_os_state;
create trigger jee_one_shot_os_updated_at
before update on public.jee_one_shot_os_state
for each row execute function public.jee_one_shot_os_set_server_updated_at();

alter table public.jee_one_shot_os_state enable row level security;

drop policy if exists jee_one_shot_os_select_own on public.jee_one_shot_os_state;
drop policy if exists jee_one_shot_os_insert_own on public.jee_one_shot_os_state;
drop policy if exists jee_one_shot_os_update_own on public.jee_one_shot_os_state;
drop policy if exists jee_one_shot_os_delete_own on public.jee_one_shot_os_state;

create policy jee_one_shot_os_select_own
  on public.jee_one_shot_os_state for select to authenticated
  using ((select auth.uid()) = user_id);
create policy jee_one_shot_os_insert_own
  on public.jee_one_shot_os_state for insert to authenticated
  with check ((select auth.uid()) = user_id);
create policy jee_one_shot_os_update_own
  on public.jee_one_shot_os_state for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
create policy jee_one_shot_os_delete_own
  on public.jee_one_shot_os_state for delete to authenticated
  using ((select auth.uid()) = user_id);

grant select, insert, update, delete on public.jee_one_shot_os_state to authenticated;

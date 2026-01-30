#!/usr/bin/bash

source /app/.env

echo "------------------------------ DUNP"

set -e

export PGPASSWORD=${POSTGRES_PASSWORD}
pg_dump -h ${POSTGRES_HOST} -U ${POSTGRES_USER} --column-inserts --data-only instil_migration > instil_migration.sql

# delete INSERT INTO django_content_type
sed -i '' '/^INSERT INTO public.django_content_type/d' instil_migration.sql
# delete INSERT INTO django_admin_log
sed -i '' '/^INSERT INTO public.django_admin_log/d' instil_migration.sql
# delete INSERT INTO django_migrations
sed -i '' '/^INSERT INTO public.django_migration/d' instil_migration.sql
# delete INSERT INTO django_session
sed -i '' '/^INSERT INTO public.django_session/d' instil_migration.sql
# delete INSERT INTO auth_permission
sed -i '' '/^INSERT INTO public.auth_permission/d' instil_migration.sql
# delete setval statements
sed -i '' '/^SELECT pg_catalog.setval/d' instil_migration.sql

pg_dump -h ${POSTGRES_HOST} -U ${POSTGRES_USER} --column-inserts --data-only instil_migration_integrations > instil_migration_integrations.sql
sed -i '' '/^INSERT INTO public.django_content_type/d' instil_migration_integrations.sql
# delete INSERT INTO django_admin_log
sed -i '' '/^INSERT INTO public.django_admin_log/d' instil_migration_integrations.sql
# delete INSERT INTO django_migrations
sed -i '' '/^INSERT INTO public.django_migration/d' instil_migration_integrations.sql
# delete INSERT INTO django_session
sed -i '' '/^INSERT INTO public.django_session/d' instil_migration_integrations.sql
# delete INSERT INTO auth_permission
sed -i '' '/^INSERT INTO public.auth_permission/d' instil_migration_integrations.sql
# delete setval statements
sed -i '' '/^SELECT pg_catalog.setval/d' instil_migration_integrations.sql

echo $(wc -l instil_migration.sql)
echo $(wc -l instil_migration_integrations.sql)


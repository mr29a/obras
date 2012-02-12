CREATE TABLE departamento (id BIGSERIAL, provincia_id BIGINT, departamento VARCHAR(200), descripcion text, PRIMARY KEY(id));
CREATE TABLE empresa (id BIGSERIAL, empresa VARCHAR(200), descripcion text, direccion VARCHAR(200), telefono VARCHAR(200), tel_cel VARCHAR(200), email VARCHAR(200), PRIMARY KEY(id));
CREATE TABLE estado_de_obra (id BIGSERIAL, estado_de_obra VARCHAR(200), descripcion text, PRIMARY KEY(id));
CREATE TABLE fuente_financiamiento (id BIGSERIAL, oganismo VARCHAR(200), descripcion text, PRIMARY KEY(id));
CREATE TABLE linea_obra (id BIGSERIAL, obra_id BIGINT, ubicacion VARCHAR(50), municipio_id BIGINT, udt_id BIGINT, descripcion text, costo_tramo FLOAT, PRIMARY KEY(id));
CREATE TABLE municipio (id BIGSERIAL, departamento_id BIGINT, udt_id BIGINT, municipio VARCHAR(200), descripcion text, PRIMARY KEY(id));
CREATE TABLE obra (id BIGSERIAL, fuentefinanc_id BIGINT, programa_id BIGINT, org_id BIGINT, tipo_obra_id BIGINT, estado_obra_id BIGINT, empresa_id BIGINT, unidad_id BIGINT, nombre_obra VARCHAR(150), detalle_obra text, cantidad FLOAT, presupuesto_oficial FLOAT, monto_contrato FLOAT, fecha_inicio DATE, fecha_fin DATE, plazo_ejecucion VARCHAR(150), organizacion VARCHAR(150), creacion VARCHAR(150), edicion VARCHAR(150), eliminacion VARCHAR(150), created_at TIMESTAMP NOT NULL, updated_at TIMESTAMP NOT NULL, PRIMARY KEY(id));
CREATE TABLE organismo (id BIGSERIAL, organismo VARCHAR(200), descripcion text, created_at TIMESTAMP NOT NULL, updated_at TIMESTAMP NOT NULL, PRIMARY KEY(id));
CREATE TABLE programa (id BIGSERIAL, programa VARCHAR(200), descripcion text, fuente_financ_id BIGINT, PRIMARY KEY(id));
CREATE TABLE provincia (id BIGSERIAL, provincia VARCHAR(200), descripcion text, PRIMARY KEY(id));
CREATE TABLE region (id BIGSERIAL, region VARCHAR(200), descripcion text, PRIMARY KEY(id));
CREATE TABLE tipo_de_obra (id BIGSERIAL, tipo_de_obra VARCHAR(200), descripcion text, PRIMARY KEY(id));
CREATE TABLE udt (id BIGSERIAL, region_id BIGINT, numero BIGINT, descripcion text, PRIMARY KEY(id));
CREATE TABLE unidad (id BIGSERIAL, unidad VARCHAR(200), descripcion text, PRIMARY KEY(id));
CREATE TABLE sf_guard_forgot_password (id BIGSERIAL, user_id BIGINT NOT NULL, unique_key VARCHAR(255), expires_at TIMESTAMP NOT NULL, created_at TIMESTAMP NOT NULL, updated_at TIMESTAMP NOT NULL, PRIMARY KEY(id));
CREATE TABLE sf_guard_group (id BIGSERIAL, name VARCHAR(255) UNIQUE, description VARCHAR(1000), created_at TIMESTAMP NOT NULL, updated_at TIMESTAMP NOT NULL, PRIMARY KEY(id));
CREATE TABLE sf_guard_group_permission (group_id BIGINT, permission_id BIGINT, created_at TIMESTAMP NOT NULL, updated_at TIMESTAMP NOT NULL, PRIMARY KEY(group_id, permission_id));
CREATE TABLE sf_guard_permission (id BIGSERIAL, name VARCHAR(255) UNIQUE, description VARCHAR(1000), created_at TIMESTAMP NOT NULL, updated_at TIMESTAMP NOT NULL, PRIMARY KEY(id));
CREATE TABLE sf_guard_remember_key (id BIGSERIAL, user_id BIGINT, remember_key VARCHAR(32), ip_address VARCHAR(50), created_at TIMESTAMP NOT NULL, updated_at TIMESTAMP NOT NULL, PRIMARY KEY(id));
CREATE TABLE sf_guard_user (id BIGSERIAL, first_name VARCHAR(255), last_name VARCHAR(255), email_address VARCHAR(255) NOT NULL UNIQUE, username VARCHAR(128) NOT NULL UNIQUE, algorithm VARCHAR(128) DEFAULT 'sha1' NOT NULL, salt VARCHAR(128), password VARCHAR(128), is_active BOOLEAN DEFAULT 'true', is_super_admin BOOLEAN DEFAULT 'false', last_login TIMESTAMP, created_at TIMESTAMP NOT NULL, updated_at TIMESTAMP NOT NULL, PRIMARY KEY(id));
CREATE TABLE sf_guard_user_group (user_id BIGINT, group_id BIGINT, created_at TIMESTAMP NOT NULL, updated_at TIMESTAMP NOT NULL, PRIMARY KEY(user_id, group_id));
CREATE TABLE sf_guard_user_permission (user_id BIGINT, permission_id BIGINT, created_at TIMESTAMP NOT NULL, updated_at TIMESTAMP NOT NULL, PRIMARY KEY(user_id, permission_id));
CREATE INDEX is_active_idx ON sf_guard_user (is_active);
ALTER TABLE departamento ADD CONSTRAINT departamento_provincia_id_provincia_id FOREIGN KEY (provincia_id) REFERENCES provincia(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE linea_obra ADD CONSTRAINT linea_obra_udt_id_udt_id FOREIGN KEY (udt_id) REFERENCES udt(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE linea_obra ADD CONSTRAINT linea_obra_obra_id_obra_id FOREIGN KEY (obra_id) REFERENCES obra(id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE linea_obra ADD CONSTRAINT linea_obra_municipio_id_municipio_id FOREIGN KEY (municipio_id) REFERENCES municipio(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE municipio ADD CONSTRAINT municipio_udt_id_udt_id FOREIGN KEY (udt_id) REFERENCES udt(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE municipio ADD CONSTRAINT municipio_departamento_id_departamento_id FOREIGN KEY (departamento_id) REFERENCES departamento(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE obra ADD CONSTRAINT obra_unidad_id_unidad_id FOREIGN KEY (unidad_id) REFERENCES unidad(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE obra ADD CONSTRAINT obra_tipo_obra_id_tipo_de_obra_id FOREIGN KEY (tipo_obra_id) REFERENCES tipo_de_obra(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE obra ADD CONSTRAINT obra_programa_id_programa_id FOREIGN KEY (programa_id) REFERENCES programa(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE obra ADD CONSTRAINT obra_org_id_organismo_id FOREIGN KEY (org_id) REFERENCES organismo(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE obra ADD CONSTRAINT obra_fuentefinanc_id_fuente_financiamiento_id FOREIGN KEY (fuentefinanc_id) REFERENCES fuente_financiamiento(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE obra ADD CONSTRAINT obra_estado_obra_id_estado_de_obra_id FOREIGN KEY (estado_obra_id) REFERENCES estado_de_obra(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE obra ADD CONSTRAINT obra_empresa_id_empresa_id FOREIGN KEY (empresa_id) REFERENCES empresa(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE programa ADD CONSTRAINT programa_fuente_financ_id_fuente_financiamiento_id FOREIGN KEY (fuente_financ_id) REFERENCES fuente_financiamiento(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE udt ADD CONSTRAINT udt_region_id_region_id FOREIGN KEY (region_id) REFERENCES region(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE sf_guard_forgot_password ADD CONSTRAINT sf_guard_forgot_password_user_id_sf_guard_user_id FOREIGN KEY (user_id) REFERENCES sf_guard_user(id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE sf_guard_group_permission ADD CONSTRAINT sf_guard_group_permission_permission_id_sf_guard_permission_id FOREIGN KEY (permission_id) REFERENCES sf_guard_permission(id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE sf_guard_group_permission ADD CONSTRAINT sf_guard_group_permission_group_id_sf_guard_group_id FOREIGN KEY (group_id) REFERENCES sf_guard_group(id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE sf_guard_remember_key ADD CONSTRAINT sf_guard_remember_key_user_id_sf_guard_user_id FOREIGN KEY (user_id) REFERENCES sf_guard_user(id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE sf_guard_user_group ADD CONSTRAINT sf_guard_user_group_user_id_sf_guard_user_id FOREIGN KEY (user_id) REFERENCES sf_guard_user(id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE sf_guard_user_group ADD CONSTRAINT sf_guard_user_group_group_id_sf_guard_group_id FOREIGN KEY (group_id) REFERENCES sf_guard_group(id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE sf_guard_user_permission ADD CONSTRAINT sf_guard_user_permission_user_id_sf_guard_user_id FOREIGN KEY (user_id) REFERENCES sf_guard_user(id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE sf_guard_user_permission ADD CONSTRAINT sf_guard_user_permission_permission_id_sf_guard_permission_id FOREIGN KEY (permission_id) REFERENCES sf_guard_permission(id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
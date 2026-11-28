CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(64) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'operator',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT users_role_check
        CHECK (role IN ('admin', 'manager', 'operator'))
);

CREATE TABLE fruits (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(120) NOT NULL UNIQUE,
    quantity_grams BIGINT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fruits_quantity_nonnegative
        CHECK (quantity_grams >= 0)
);

CREATE TABLE movements (
    id BIGSERIAL PRIMARY KEY,
    fruit_id BIGINT NOT NULL REFERENCES fruits(id),
    user_id BIGINT NOT NULL REFERENCES users(id),
    movement_type VARCHAR(16) NOT NULL,
    quantity_grams BIGINT NOT NULL,
    note TEXT NOT NULL DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT movements_type_check
        CHECK (movement_type IN ('receive', 'dispatch')),

    CONSTRAINT movements_quantity_positive
        CHECK (quantity_grams > 0)
);
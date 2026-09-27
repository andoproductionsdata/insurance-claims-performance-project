CREATE TABLE claim (
    claim_id VARCHAR(4) PRIMARY KEY,
    account_number VARCHAR(10),
    claim_status VARCHAR(10), -- claim Status A, D, C, O
    date DATE,
	partition_date DATE,
    owner VARCHAR(50),
	claim_type VARCHAR(50), -- Claim_type Critcal Illness, Death, Disability, Hospital Services
)
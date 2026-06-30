-- =========================================================================
-- Migration 001 : Tables de l'Automation Suite (CDC Section 4)
-- =========================================================================
-- Ce script est exécuté automatiquement par MySQL au PREMIER démarrage
-- du container (mécanisme docker-entrypoint-initdb.d).
-- Il ne s'exécute PAS si le volume mysql_data existe déjà.
-- =========================================================================

-- Table A : Configuration et règles comportementales des campagnes de recette
CREATE TABLE automation_campaigns_cfg (
  id_campagne INT AUTO_INCREMENT PRIMARY KEY,
  client_id INT NOT NULL,
  liste_test_cases JSON NOT NULL,
  on_error_action VARCHAR(20) DEFAULT 'CONTINUE',
  send_email_report BOOLEAN DEFAULT TRUE,
  email_destinataires TEXT,
  created_by VARCHAR(100) NOT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table B : Journalisation, métriques et logs détaillés des exécutions
CREATE TABLE automation_campaigns_logs (
  id_log INT AUTO_INCREMENT PRIMARY KEY,
  id_campagne INT NOT NULL,
  execution_token VARCHAR(255),
  timestamp_debut TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  timestamp_fin TIMESTAMP NULL,
  total_tests INT DEFAULT 0,
  tests_succes INT DEFAULT 0,
  tests_echecs INT DEFAULT 0,
  statut_final VARCHAR(30),
  executed_by VARCHAR(100) NOT NULL,
  payload_rapport_blob LONGTEXT,
  FOREIGN KEY (id_campagne) REFERENCES automation_campaigns_cfg(id_campagne)
);
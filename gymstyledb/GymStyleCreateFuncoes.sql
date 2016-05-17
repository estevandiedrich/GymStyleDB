
DROP TRIGGER IF EXISTS digitais_usuario on digitais;
DROP FUNCTION IF EXISTS atualiza_status_sincronizado();
DROP TRIGGER IF EXISTS campos_usuarios on usuarios;
DROP FUNCTION IF EXISTS atualiza_status_usuario();

CREATE OR REPLACE FUNCTION removeAcento(character varying) 
  RETURNS text AS 
$BODY$ 
    select translate($1, 'áàâãäéèêëíìïóòôõöúùûüÁÀÂÃÄÉÈÊËÍÌÏÓÒÔÕÖÚÙÛÜçÇ', 
	'aaaaaeeeeiiiooooouuuuAAAAAEEEEIIIOOOOOUUUUcC'); 
$BODY$ 
  LANGUAGE 'sql'; 


CREATE OR REPLACE FUNCTION remove_requisicao_resposta() RETURNS TRIGGER AS $requisicao$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            DELETE FROM respostas WHERE destino = OLD.id_requisicao;
	    RETURN OLD;
        END IF;
        RETURN NULL;
    END;
$requisicao$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_status_sincronizado() RETURNS TRIGGER AS $digitais_usuario$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            UPDATE usuarios SET sincronizado=false WHERE id_usuarios = OLD.id_usuarios_fk;
	    RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
        UPDATE usuarios SET sincronizado=false WHERE id_usuarios = NEW.id_usuarios_fk;
            RETURN NEW;
        END IF;
        RETURN NULL; 
    END;
$digitais_usuario$ LANGUAGE plpgsql;

CREATE TRIGGER digitais_usuario AFTER INSERT OR UPDATE OR DELETE ON digitais FOR EACH ROW EXECUTE PROCEDURE atualiza_status_sincronizado();

CREATE OR REPLACE FUNCTION atualiza_status_usuario() RETURNS TRIGGER AS $campos_usuarios$
    BEGIN
	IF (TG_OP = 'UPDATE') THEN
           IF (NEW.nome <> OLD.nome) THEN
	      
	      UPDATE usuarios SET sincronizado=false WHERE id_usuarios = NEW.id_usuarios;
              RETURN NEW;
	   ELSIF (NEW.cartao_proximidade != OLD.cartao_proximidade) THEN
	      UPDATE usuarios SET sincronizado=false WHERE id_usuarios = NEW.id_usuarios;
              RETURN NEW;
	   ELSIF (NEW.cartao_proximidade is null AND OLD.cartao_proximidade is not null) THEN
	      UPDATE usuarios SET sincronizado=false WHERE id_usuarios = NEW.id_usuarios;
              RETURN NEW;
	   ELSIF (NEW.cartao_proximidade is not null AND OLD.cartao_proximidade is null) THEN
	      UPDATE usuarios SET sincronizado=false WHERE id_usuarios = NEW.id_usuarios;
              RETURN NEW;
           END IF;
           RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$campos_usuarios$ LANGUAGE plpgsql;


CREATE TRIGGER campos_usuarios AFTER UPDATE ON usuarios FOR EACH ROW EXECUTE PROCEDURE atualiza_status_usuario();

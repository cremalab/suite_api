class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.datetime :when
      t.text :description
      t.references :user, index: true
      t.references :idea_thread, index: true

      t.timestamps
    end
    sql = ("CREATE FUNCTION notify_trigger() RETURNS trigger AS $$
            DECLARE
            BEGIN
              PERFORM pg_notify('ideas_ch', TG_TABLE_NAME || ',id,' || NEW.id );
              RETURN new;
            END;
            $$ LANGUAGE plpgsql;
            CREATE TRIGGER ideas_trigger AFTER INSERT ON ideas
            FOR EACH ROW EXECUTE PROCEDURE notify_trigger();")
    execute sql
  end
end

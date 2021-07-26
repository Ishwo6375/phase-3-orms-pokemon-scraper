class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(name:, type:, db:, id:)
        @name = name
        @type = type
        @db = db
        @id = id
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon
            WHERE id = ?
            LIMIT 1
        SQL

        db.execute(sql, id).map do |row|
            id = row[0]
            name = row[1]
            type = row[2]
            self.new(name: name, type: type, db: db, id: id)
        end.first
    end
end
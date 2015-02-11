require 'sequel'
require 'time'

module Certmeister

  module Pg

    class Store

      include Enumerable

      def initialize(connection_string, options = {})
        @db = Sequel.connect(connection_string, options)
        @db.create_table? :certificates do
          primary_key :id
          String :cn, unique: true, null: false
          File :pem, null: false
          Time :created_at, null: false
          Time :updated_at, null: false
        end
        @certificates = @db[:certificates]
        @healthy = true
      end

      def store(cn, pem)
        now = Time.now
        if 1 != @certificates.where('cn = ?', cn).update(pem: pem, updated_at: now)
          @certificates.insert(cn: cn, pem: pem, created_at: now, updated_at: now)
        end
      end

      def fetch(cn)
        if cert = @certificates[cn: cn]
          cert[:pem]
        end
      end

      def remove(cn)
        num_removed = @certificates.where('cn = ?', cn).delete
        num_removed == 1
      end

      def each
        @certificates.each do |row|
          yield row[:cn], row[:pem]
        end
      end

      def health_check
        @healthy
      end

      private

      def break!
        @healthy = false
      end

    end

  end

end

require 'spec_helper'
require 'certmeister/test/memory_store_interface'

require 'certmeister/pg/store'

describe Certmeister::Pg::Store do

  class << self
    include Certmeister::Test::MemoryStoreInterface
  end

  subject { Certmeister::Pg::Store.new('postgres://localhost/test') }

  it_behaves_like_a_certmeister_store

  private

  def pg_cleanup
    begin
      db = Sequel.connect('postgres://localhost/test')
      certs = db[:certificates]
      certs.where('cn IN ?', ["axl.starjuice.net", "axl.hetzner.africa"]).delete
    rescue Sequel::DatabaseError => e
      if e.message =~ /PG::UndefinedTable/
        # Table doesn't exist the first time we test
      else
        raise
      end
    end
  end

  before(:each) do
    pg_cleanup
  end

  after(:each) do
    pg_cleanup
  end

end


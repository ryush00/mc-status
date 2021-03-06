require_relative '../lib/server_updater'

module MCStatus
  module Models
    class Server
      include Mongoid::Document

      store_in :database => 'mc_servers', :collection => 'servers'
      index({ :minecraft_ip => 1}, { :unique => true, :name => 'ip_index'})

      has_many :pings

      field :name, :type => String
      field :website, :type => String
      field :minecraft_ip, :type => String

      def to_api_format
        {
          :_id => self.id.to_s,
          :name => self.name,
          :website => self.website,
          :minecraft => self.minecraft_ip
        }
      end

      def ping!
        MCStatus::ServerUpdater.new([self]).update!
      end
    end
  end
end

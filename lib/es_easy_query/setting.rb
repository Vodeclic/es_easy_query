module EsEasyQuery

  # Tis is jus a thing wrapper around your json file
  class Setting

    attr_reader :settings, :mappings
    attr_reader :setting_path

    class SettingNotFound < StandardError; end

    class << self
      def lookup_settings_path(name)
        path = Rails.root.join(EsEasyQuery.settings_path, "#{name}.json")
        raise SettingNotFound, "Not setting found for #{name}" unless path.exist?
        path
      end
    end

    def initialize(setting_path)
      @setting_path = setting_path
      read
    end

    def read
      @source_settings = JSON.parse(File.read(@setting_path))
      @settings = @source_settings["settings"]
      @mappings = @source_settings["mappings"]
    end

  end

end

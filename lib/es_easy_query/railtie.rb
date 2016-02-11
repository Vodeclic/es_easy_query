module EsEasyQuery

  class Railtie < Rails::Railtie

    # config.autoload_paths << %W(#{Rails.root}/app/es_queries)
    initializer 'es_easy_query.autoload', after: :set_autoload_paths do |app|
      app.config.paths.add EsEasyQuery.queries_path, eager_load: true
    end

  end

end

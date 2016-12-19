require 'engaging_networks/request/multitoken'

module EngagingNetworks
  class API < Vertebrae::API

    def request(*args)
      EngagingNetworks::Response::Wrapper.new( super(*args) )
    end

    def default_options
      {
        user_agent: 'EngagingNetworksGem',
        host: 'e-activist.com',
        content_type: 'application/x-www-form-urlencoded'
      }
    end

    def extract_data_from_params(params) # :nodoc:
      if params.has_key?('data') && params['data'].present?
        return params['data']
      else
        return params
      end
    end

    def setup
      connection.stack do |builder|
        #request middleware first, in order of importance
        builder.use EngagingNetworks::Request::MultiTokenAuthentication,
          :public_token => connection.configuration.options[:public_token],
          :private_token => connection.configuration.options[:private_token]

        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded

        #response middleware second, in reverse order of importance
        builder.use FaradayMiddleware::ParseXml,  :content_type => /\bxml$/
        
        builder.use Faraday::Response::Logger if ENV['DEBUG']

        builder.use EngagingNetworks::Response::RaiseError
        builder.adapter connection.configuration.adapter
      end
    end

    def request_with_options(method, path, params, options) # :nodoc:
      if !::Vertebrae::Request::METHODS.include?(method)
        raise ArgumentError, "unknown http method: #{method}"
      end
      connection.options = default_options.merge(options)
      path =  connection.configuration.prefix + '/' + path

      ::Vertebrae::Base.logger.debug "EXECUTED: #{method} - #{path} with #{params} and #{options}"

      connection.connection.send(method) do |request|

        case method.to_sym
          when *(::Vertebrae::Request::METHODS - ::Vertebrae::Request::METHODS_WITH_BODIES)
            request.url(path, params)
          when *::Vertebrae::Request::METHODS_WITH_BODIES
            request.path = path
            request.body = params
        end
      end
    end

    def post_request_with_get_params(path, get_params, post_data, options={}) # :nodoc:
      method = :post

      if !::Vertebrae::Request::METHODS.include?(method)
        raise ArgumentError, "unknown http method: #{method}"
      end

      path =  connection.configuration.prefix + '/' + path

      ::Vertebrae::Base.logger.debug "EXECUTED: #{method} - #{path}? #{get_params} with #{post_data} and #{options}"

      connection.connection.send(method) do |request|

        case method.to_sym
          when *(::Vertebrae::Request::METHODS - ::Vertebrae::Request::METHODS_WITH_BODIES)
            request.body = get_params.delete('data') if get_params.has_key?('data')
            request.url(path, get_params)
          when *::Vertebrae::Request::METHODS_WITH_BODIES
            request.path = path
            request.body = extract_data_from_params(post_data) unless post_data.empty?
            request.url(path, get_params)
        end
      end
    end
  end
end

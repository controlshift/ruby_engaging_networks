module EngagingNetworks
  module Response
    class Wrapper
      include Enumerable
      extend Forwardable

      attr_reader :response
      attr_reader :kind
      attr_reader :obj

      def_delegators :body, :empty?, :size, :include?, :length, :to_a, :first, :flatten, :include?, :keys, :[]

      def initialize(response)
        @response    = response

        if response.body.respond_to?('has_key') && response.body.has_key?('EaData')
          @kind = :collection
          @obj = EngagingNetworks::Response::Collection.new(response.body['EaData'])
        else
          @kind = :object
          @obj = response.body
        end
      end

      def collection?
        kind == :collection
      end

      def object?
        kind == :object
      end

      # Request url
      def url
        response.env[:url].to_s
      end

      def body=(value)
        @body = value
        @env[:body] = value
      end

      # Response raw body
      def body
        @body ? @body : response.body
      end

      # Response status
      def status
        response.status
      end

      def success?
        response.success?
      end

      def redirect?
        status.to_i >= 300 && status.to_i < 400
      end

      def client_error?
        status.to_i >= 400 && status.to_i < 500
      end

      def server_error?
        status.to_i >= 500 && status.to_i < 600
      end

      # Lookup an attribute from the body if hash, otherwise behave like array index.
      # Convert any key to string before calling.
      #
      def [](key)
        if self.body.is_a?(Array)
          self.body[key]
        else
          self.body.send(:"#{key}")
        end
      end

      # Return response body as string
      #
      def to_s
        body.to_s
      end

      # Convert the ResponseWrapper into a Hash
      #
      def to_hash
        body.to_hash
      end

      # Convert the ResponseWrapper into an Array
      #
      def to_ary
        body.to_ary
      end

      # if a raw object, just delegate
      def method_missing(method_name, *args, &block)
        if object?
          obj.send(method_name, &block)
        else
          super
        end
      end

      # Iterate over each resource inside the collection
      #
      def each(&block)
        if collection?
          obj.each do |o|
            block.call(o)
          end
        else
          raise("can only iterate over collections")
        end
      end
    end
  end
end
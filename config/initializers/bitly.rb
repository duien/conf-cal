bitly_config_file = File.join(Rails.root, 'config', 'bitly.yml')
bitly_config = if File.exists?(bitly_config_file)
                 YAML.load_file(bitly_config_file)
               else
                 { 'username' => ENV['BITLY_USERNAME'],
                   'api_key'  => ENV['BITLY_API_KEY'] }
               end

Bitly.use_api_version_3
BITLY = Bitly.new( bitly_config['username'], bitly_config['api_key'] )

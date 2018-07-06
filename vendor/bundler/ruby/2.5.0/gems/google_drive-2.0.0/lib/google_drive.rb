# Author: Hiroshi Ichikawa <http://gimite.net/>
# The license of this source is "New BSD Licence"

require 'json'
require 'googleauth'

require 'google_drive/session'

module GoogleDrive
  # Authenticates with given OAuth2 token.
  #
  # +access_token+ can be either OAuth2 access_token string, OAuth2::AccessToken
  # or credentials generated by googleauth library.
  #
  # OAuth2 code example for Web apps:
  #
  #   require "googleauth"
  #   
  #   credentials = Google::Auth::UserRefreshCredentials.new(
  #     client_id: "YOUR CLIENT ID",
  #     client_secret: "YOUR CLIENT SECRET",
  #     scope: [
  #       "https://www.googleapis.com/auth/drive",
  #       "https://spreadsheets.google.com/feeds/",
  #     ],
  #     redirect_uri: "http://example.com/redirect")
  #   auth_url = credentials.authorization_uri
  #   # Redirect the user to auth_url and get authorization code from redirect URL.
  #   credentials.code = authorization_code
  #   credentials.fetch_access_token!
  #   session = GoogleDrive.login_with_oauth(credentials)
  #
  # credentials.access_token expires in 1 hour. If you want to restore a session afterwards, you can store
  # credentials.refresh_token somewhere after auth.fetch_access_token! above, and use this code:
  #
  #   require "googleauth"
  #   
  #   credentials = Google::Auth::UserRefreshCredentials.new(
  #     client_id: "YOUR CLIENT ID",
  #     client_secret: "YOUR CLIENT SECRET",
  #     scope: [
  #       "https://www.googleapis.com/auth/drive",
  #       "https://spreadsheets.google.com/feeds/",
  #     ],
  #     redirect_uri: "http://example.com/redirect")
  #   credentials.refresh_token = refresh_token
  #   credentials.fetch_access_token!
  #   session = GoogleDrive.login_with_oauth(credentials.access_token)
  #
  # For command-line apps, it would be easier to use saved_session method instead.
  def self.login_with_oauth(client_or_access_token, proxy = nil)
    Session.new(client_or_access_token, proxy)
  end

  # Returns GoogleDrive::Session constructed from a config JSON file at +path+.
  #
  # Follow the following steps to use this method:
  #
  # First, follow "Create a client ID and client secret" in
  # {this page}[https://developers.google.com/drive/web/auth/web-server] to get a client ID
  # and client secret for OAuth. Set "Application type" to "Other" in the form to create a
  # client ID if you use GoogleDrive.saved_session method as in the example below.
  #
  # Next, create a file config.json which contains the client ID and client secret you got
  # above, which looks like:
  #
  #   {
  #     "client_id": "xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com",
  #     "client_secret": "xxxxxxxxxxxxxxxxxxxxxxxx"
  #   }
  #
  # Then you can construct a GoogleDrive::Session by:
  #
  #   session = GoogleDrive.saved_session("config.json")
  #
  # This will prompt the credential via command line for the first time and save it to
  # config.json file for later usages.
  #
  # +path+ defaults to ENV["HOME"] + "/.ruby_google_drive.token".
  #
  # If the file doesn't exist or client ID/secret are not given in the file, the default client
  # ID/secret embedded in the library is used.
  #
  # You can also provide a config object that must respond to:
  #   client_id
  #   client_secret
  #   refesh_token
  #   refresh_token=
  #   scope
  #   scope=
  #   save
  def self.saved_session(
      path_or_config = nil, proxy = nil, client_id = nil, client_secret = nil)
    config = case path_or_config
             when String
               Config.new(path_or_config)
             when nil
               Config.new(ENV['HOME'] + '/.ruby_google_drive.token')
             else
               path_or_config
    end

    config.scope ||= [
      'https://www.googleapis.com/auth/drive',
      'https://spreadsheets.google.com/feeds/'
    ]

    if client_id && client_secret
      config.client_id = client_id
      config.client_secret = client_secret
    end
    if !config.client_id && !config.client_secret
      config.client_id = '452925651630-egr1f18o96acjjvphpbbd1qlsevkho1d.apps.googleusercontent.com'
      config.client_secret = '1U3-Krii5x1oLPrwD5zgn-ry'
    elsif !config.client_id || !config.client_secret
      fail(ArgumentError, 'client_id and client_secret must be both specified or both omitted')
    end

    if proxy
      fail(
        ArgumentError,
        'Specifying a proxy object is no longer supported. Set ENV["http_proxy"] instead.')
    end

    refresh_token = config.refresh_token

    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: config.client_id,
      client_secret: config.client_secret,
      scope: config.scope,
      redirect_uri: 'urn:ietf:wg:oauth:2.0:oob')

    if config.refresh_token
      credentials.refresh_token = config.refresh_token
      credentials.fetch_access_token!
    else
      $stderr.print("\n1. Open this page:\n%s\n\n" % credentials.authorization_uri)
      $stderr.print('2. Enter the authorization code shown in the page: ')
      credentials.code = $stdin.gets.chomp
      credentials.fetch_access_token!
      config.refresh_token = credentials.refresh_token
    end

    config.save

    GoogleDrive.login_with_oauth(credentials)
  end
end
module DropboxApi::Errors
  class SearchError < BasicError
    ErrorSubtypes = {
      :path => LookupError
    }.freeze
  end
end

module DropboxApi::Errors
  class GetMetadataError < BasicError
    ErrorSubtypes = {
      :path => LookupError
    }.freeze
  end
end

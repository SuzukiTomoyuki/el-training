module DropboxApi::Errors
  class ListFolderError < BasicError
    ErrorSubtypes = {
      :path => LookupError
    }.freeze
  end
end

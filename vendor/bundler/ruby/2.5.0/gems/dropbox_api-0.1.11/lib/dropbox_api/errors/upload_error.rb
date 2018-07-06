module DropboxApi::Errors
  class UploadError < BasicError
    ErrorSubtypes = {
      :path => UploadWriteFailedError
    }.freeze
  end
end

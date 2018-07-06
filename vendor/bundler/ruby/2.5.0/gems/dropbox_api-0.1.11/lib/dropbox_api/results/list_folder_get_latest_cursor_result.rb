module DropboxApi::Results
  class ListFolderGetLatestCursorResult < DropboxApi::Results::Base
    def cursor
      @data["cursor"]
    end
  end
end

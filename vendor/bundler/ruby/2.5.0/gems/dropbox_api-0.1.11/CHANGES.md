This file aims to compile all the breaking changes introduced in each version.

### Version 0.2

- `list_folder_members` changed its signature from
  `list_folder_members(folder_id, options = {})` to
  `list_folder_members(folder_id, actions = [], options = {})`

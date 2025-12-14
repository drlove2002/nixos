# VS Code Keybindings - Vim-style Navigation in File Explorer
# Organized into functional groups

let
  # Helper function to create a keybinding
  binding =
    {
      key,
      command,
      when ? "filesExplorerFocus && !inputFocus",
    }:
    {
      inherit key command when;
    };

  # Helper for disabling default bindings (command starts with -)
  unbind =
    {
      key,
      command,
      when ? "filesExplorerFocus && !inputFocus",
    }:
    {
      inherit key when;
      command = "-${command}";
    };

in
[
  # ============================================================================
  # NAVIGATION (hjkl movement)
  # ============================================================================

  # Move up
  (binding {
    key = "k";
    command = "list.focusUp";
  })

  # Move down
  (binding {
    key = "j";
    command = "list.focusDown";
  })

  # Move left (collapse/parent directory)
  (binding {
    key = "h";
    command = "list.collapse";
  })

  # Move right (expand/open directory)
  (binding {
    key = "l";
    command = "list.expand";
  })

  # ============================================================================
  # JUMP NAVIGATION
  # ============================================================================

  # Jump to last item
  (binding {
    key = "shift+g";
    command = "list.focusLast";
  })

  # Jump to first item (vim-style gg)
  (binding {
    key = "g g";
    command = "list.focusFirst";
  })

  # Page up
  (binding {
    key = "ctrl+u";
    command = "list.focusPageUp";
  })

  # Page down
  (binding {
    key = "ctrl+d";
    command = "list.focusPageDown";
  })

  # ============================================================================
  # FILE/FOLDER OPERATIONS
  # ============================================================================

  # Create new file
  (binding {
    key = "a";
    command = "explorer.newFile";
  })

  # Create new folder
  (binding {
    key = "f";
    command = "explorer.newFolder";
  })

  # Rename file/folder
  (binding {
    key = "r";
    command = "renameFile";
  })

  # Delete file/folder
  (binding {
    key = "d";
    command = "moveFileToTrash";
  })

  # Copy file/folder
  (binding {
    key = "y";
    command = "filesExplorer.copy";
  })

  # Paste file/folder
  (binding {
    key = "p";
    command = "filesExplorer.paste";
  })

  # Cut file/folder
  (binding {
    key = "x";
    command = "filesExplorer.cut";
  })

  # ============================================================================
  # OPEN/EDIT OPERATIONS
  # ============================================================================

  # Open file in editor
  (binding {
    key = "o";
    command = "list.select";
  })

  # Open file in split (vertical)
  (binding {
    key = "shift+o";
    command = "explorer.openToSide";
  })

  # Open with preview
  (binding {
    key = "space";
    command = "explorer.openAndPassFocus";
  })

  # ============================================================================
  # SEARCH AND FILTER
  # ============================================================================

  # Quick open (search in explorer)
  (binding {
    key = "/";
    command = "workbench.action.quickOpen";
  })

  # Find in files (vim-style :find)
  (binding {
    key = "shift+f";
    command = "workbench.view.search";
  })

  # ============================================================================
  # REFRESH AND VISIBILITY
  # ============================================================================

  # Refresh explorer
  (binding {
    key = "shift+r";
    command = "explorer.refresh";
  })

  # Toggle explorer visibility
  (binding {
    key = "ctrl+shift+e";
    command = "workbench.action.toggleSidebarVisibility";
    when = "filesExplorerFocus";
  })

  # ============================================================================
  # EXPANSION/COLLAPSE
  # ============================================================================

  # Expand recursively
  (binding {
    key = "shift+l";
    command = "list.expandRecursively";
  })

  # Collapse recursively
  (binding {
    key = "shift+h";
    command = "list.collapseAll";
  })

  # ============================================================================
  # TERMINAL OPERATIONS
  # ============================================================================

  # Focus terminal when not focused
  {
    key = "ctrl+shift+t";
    command = "workbench.action.terminal.focus";
    when = "!terminalFocus";
  }

  # Return to editor when terminal is focused
  {
    key = "ctrl+shift+t";
    command = "workbench.action.focusActiveEditorGroup";
    when = "terminalFocus";
  }

  # ============================================================================
  # OVERRIDE DEFAULT BINDINGS
  # ============================================================================

  # Remove default Alt+1 for sidebar toggle
  (unbind {
    key = "alt+1";
    command = "workbench.action.toggleSidebarVisibility";
    when = "explorerViewletFocus";
  })

  # Remove conflicting o binding
  (unbind {
    key = "o";
    command = "explorer.openAndPassFocus";
  })

  # ============================================================================
  # DISABLE Ctrl+Shift+T CONFLICTS
  # ============================================================================

  # Remove Ctrl+Shift+T for Merge Editor: Toggle Between
  (unbind {
    key = "ctrl+shift+t";
    command = "editor.action.toggleMergeEditor";
  })

  # Remove Ctrl+Shift+T for View: Reopen Closed Editor
  (unbind {
    key = "ctrl+shift+t";
    command = "workbench.action.reopenClosedEditor";
  })

  # Remove Ctrl+Shift+T for Java test go to test
  {
    key = "ctrl+shift+t";
    command = "-java.test.goToTest";
    when = "editorTextFocus && editorLangId == java";
  }
]

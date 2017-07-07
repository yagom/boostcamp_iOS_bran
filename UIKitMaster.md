### First Steps

  - class UIView

  An object that represents a rectangular area on the screen and manages the content in that area.

### Container Views

  #### Collection Views

  - Collection Views

  Display nested views using a configurable and highly customizable layout.

  #### TableViews

  ###### View


  - class UITableView

  A view that presents data using rows arranged in a single column.

  iOS 2.0+ / tvOS 2.0+

  - UITableViewController

  A controller object that manages a table view.

  iOS 2.0+ / tvOS 2.0+

  - UITableViewFocusUpdateContext

  A context object that provides information relevant to a specific focus update from one view to another.
  iOS 9.0+ / tvOS 9.0+

  - UILocalizedIndexedCollation

  An object that provides ways to organize, sort, and localize the data for a table view that has a section index.

  iOS 3.0+ / tvOS 3.0+

  ###### Rows


  - UITableViewCell

  A cell in a table view.

  iOS 2.0+ / tvOS 2.0+

  - UISwipeActionsConfiguration

  The set of actions to perform when swiping on rows of a table.

  Beta

  - UIContextualAction

  An action to display when the user swipes a table row.

  Beta

  - UITableViewRowAction

  A single action to present when the user swipes horizontally in a table row.

  iOS 8.0+

  - enum UIContextualAction.Style

  Constants indicating the style information that is applied to the action button.

  Beta

  ###### Headers and Footers


  - UITableViewHeaderFooterView

  A reusable view that can be placed at the top or bottom of a table section to display additional information for that section.

  iOS 6.0+ / tvOS 6.0+

  ###### Adornments


  - UIRefreshControl

  A standard control that can initiate the refreshing of a table view’s contents.

  iOS 6.0+

  ###### Drag and Drop

  - protocol UITableViewDragDelegate

  The interface for initiating drags from a table view.

  Beta

  - protocol
   UITableViewDropDelegate

  The interface for handling drops in a table view.

  Beta

  - protocol UITableViewDropCoordinator

  An interface for coordinating your custom drop-related actions with the table view.

  Beta

  - UITableViewDropProposal

  Your proposed solution for handling a drop in a table view.

  Beta

  - protocol UITableViewDropItem

  The data associated with an item being dropped into the table view.

  Beta

  - protocol UITableViewDropPlaceholderContext

  An object that you insert temporarily into the table view while waiting to receive the actual data that you plan to display.

  Beta

  - protocol UIDataSourceTranslating

  An advanced interface for managing a data source object.

  Beta

  - class UIStackView

    A streamlined interface for laying out a collection of views in either a column or a row.

    iOS 9.0+ / tvOS 9.0+

  - class UIScrollView

    A view that allows the scrolling and zooming of its contained views.

    iOS 2.0+ / tvOS 2.0+

### Content Views

  - class UIActivityIndicatorView

    A view that shows that a task is in progress.

    iOS 2.0+ / tvOS 2.0+

  - class UIImageView

  An object that displays a single image or a sequence of animated images in your interface.

  iOS 2.0+ / tvOS 2.0+

  - class UIPickerView

  A view that uses a spinning-wheel or slot-machine metaphor to show one or more sets of values.

  iOS 2.0+


  - class UIProgressView

  A view that depicts the progress of a task over time.

  iOS 2.0+ / tvOS 2.0+

  - class UIWebView

  A view that embeds web content in your app.

  iOS 2.0+

### Controls

  - class UIControl

  The base   - class for controls, which are visual elements that convey a specific action or intention in response to user interactions.

  iOS 2.0+
tvOS 2.0+

  - class UIButton

  A control that executes your custom code in response to user interactions.

  iOS 2.0+ / tvOS 2.0+

  - class UIDatePicker

  A control used for the inputting of date and time values.

  iOS 2.0+


  - class UIPageControl

  A control that displays a horizontal series of dots, each of which corresponds to a page in the app’s document or other data-model entity.

  iOS 2.0+ / tvOS 2.0+

  - class UISegmentedControl

  A horizontal control made of multiple segments, each segment functioning as a discrete button.

  iOS 2.0+ / tvOS 2.0+

  - class UISlider

  A control used to select a single value from a continuous range of values.

  iOS 2.0+

  - class UIStepper

  A control used to increment or decrement a value.

  iOS 5.0+


  - class UISwitch

  A control that offers a binary choice, such as On/Off.
Text Views

  iOS 2.0+


  - class UILabel

  A view that displays one or more lines of read-only text, often used in conjunction with controls to describe their intended purpose.

  iOS 2.0+ / tvOS 2.0+

  - class UITextField
  An object that displays an editable text area in your interface.

  iOS 2.0+ / tvOS 2.0+

  - class UITextView

  A scrollable, multiline text region.
Drag-and-Drop Customization
Extend the standard drag-and-drop support for text views to include custom types of content.
Bars

iOS 2.0+ / tvOS 2.0+

  - class UIBarItem

  An abstract super  - class for items that can be added to a bar that appears at the bottom of the screen.

  iOS 2.0+ / tvOS 2.0+

  - class UIBarButtonItem

  A button specialized for placement on a toolbar or tab bar.

  iOS 2.0+ / tvOS 2.0+

  - class UIBarButtonItemGroup

  A set of bar button items on the shortcuts bar above the keyboard on iPad.

  iOS 9.0+ / tvOS 9.0+

  - class UINavigationBar

  A control that supports navigation of hierarchical content, most often used in navigation controllers.

  iOS 2.0+ / tvOS 2.0+

  - class UISearchBar

  A text field–like control that supports text-based searches.

  iOS 2.0+ / tvOS 2.0+


  - class UIToolbar

  A control that displays one or more buttons along the bottom edge of your interface.

  iOS 2.0+

  - class UITabBar

  A control that displays one or more buttons in a tab bar for selecting between different subtasks, views, or modes in an app.

  iOS 2.0+ / tvOS 2.0+

  - class UITabBarItem

  An item in a tab bar.

  iOS 2.0+ / tvOS 2.0+

  - protocol UIBarPositioning

  A set of methods for defining the ways that bars can be positioned in iOS apps.

  iOS 7.0+ / tvOS 9.0+

  - protocol UIBarPositioningDelegate

  A set of methods that support the positioning of a bar that conforms to the

  iOS 7.0+ / tvOS 9.0+

  - UIBarPositioning
 protocol.

 iOS 7.0+ / tvOS 9.0+

### Menus

  - class UIMenuController

  The menu interface for the Cut, Copy, Paste, Select, Select All, and Delete commands.

  - class UIMenuItem

  A custom item in the editing menu managed by the
UIMenuController object.

###  Visual Adornments

  - class UIVisualEffect

  An initializer for visual effect views and blur and vibrancy effect objects.

  iOS 8.0+ / tvOS 8.0+

  - class UIVisualEffectView

  An object that implements some complex visual effects.

  iOS 8.0+ / tvOS 8.0+

  - class UIVibrancyEffect

  An object that amplifies and adjusts the color of the content layered behind a visual effect view.

  iOS 8.0+ / tvOS 8.0+

  - class UIBlurEffect

  An object that applies a blurring effect to the content layered behind a visual effect view.

  iOS 8.0+ / tvOS 8.0+

### Appearance Customization
  - protocol UIAppearance

  A collection of methods that gives you access to the appearance proxy for a   - class.

  iOS 5.0+ / tvOS 9.0+

  - protocol UIAppearanceContainer

  A protocol that a class must adopt to allow appearance customization using the UIAppearance API.

 iOS 5.0+ / tvOS 9.0+

### Related Types
  - struct UIEdgeInsets

  The inset distances for views.

  iOS 2.0+ / tvOS 9.0+ / watchOS 2.0+

  - struct NSDirectionalEdgeInsets

  Edge insets that take language direction into account.

  Beta

  - struct UIOffset

  Defines a structure that specifies an amount to offset a position.

  iOS 5.0+ / tvOS 9.0+ / watchOS 2.0+

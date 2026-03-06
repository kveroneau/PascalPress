# Database Table: BlogFS

Based on a super simple virtual file system I created decades ago and keeps changing and evolving.  The iteration of it here has many new enhancements, namely the inclusion of blog specific meta-data!

This table is the main workhorse for **PascalPress**.  In most cases, it handles all the routing between article requests.  When a visitor first visits **PascalPress**, their request will be routed through this table to determine which content will be displayed to the visitor on the page itself.

From a non-technical perspective, it will provide article authors with an explorer-like view of their website's content, where they can add new folders and new files to.  The author should only care where their content should go in the overall site, and the content itself.

The two main fields in the table that control the placement are the `title` and `location` fields.  This does not work as you might expect either, as each individual `location` works more like a *volume* than an actual container.  For example, if you place a folder called **Android** in both a separate **Smartphone** and **Tablet** folder, the **Android** folder will always contain the same content.  It works more like a hard link on UNIX-like systems.  This also means, at least for the current moment, if you delete a folder object from the file system, the actual contents of that folder will still remain, and so they can be once again accessed by creating another folder with the exact same name.  This functionality may change in the future, where deleting a folder may also allow the deletion of all it contains.  At the moment of this writing, all the content needs to be manually deleted inside a folder to truly remove it's content.

### Content-Types

The aptly named `type` field is an integer which stores the content-type, which can be expanded with additional types.  At the moment, all added types need to be sequential as they are also used to display the icon in the desktop adminstrative application.  Documentation on how to add additional custom types will be provided in the future.

**Currently supported types**

  * Text Document: Just pure text data, when rendered it will be wrapped in a `pre` HTML tag.
  * Folder: A place to put documents.
  * HTML Document: Just that, a document with pure HTML that will be rendered as-is to the page.

A Markdown document type will be supported in the next coming days.

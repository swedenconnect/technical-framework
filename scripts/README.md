## Converting specifications into HTML

All releases of the Swedish eID Framework are published to <https://docs.swedenconnect.se/technical-framework>. We use the script `tohtml.sh` to produce HTML from our specifications written in Markdown. This script also sets up the CSS-files for printing the HTML-files.

### Prerequisites

In order to run the `tohtml.sh` script you need the following:

* Not be on a Windows machine ...
* Have a working installation of [Node.js](https://nodejs.org).
* Install generate-md, see <https://github.com/mixu/markdown-styles>.

### Usage

    usage: tohtml.sh <markdown file> <output directory> [-o <orientation>]
      Where orientation is p (for portrait) or l (for landscape).
      The 'orientation' is for printing.

When running the `tohtml.sh` script you may assign the page orientation to be used when printing the resulting HTML. Portrait mode is default, but some specifications are better suited in landscape mode (due to wide tables).

### Producing PDF

Currently, we haven't found a good enough CLI tool to take us from HTML to PDF. The available ones doesn't follow CSS very well. Therefore, the solution at this point is to use Google Chrome and "Print to PDF". Remember to uncheck the "Headers and footers" option and to check the "Background graphics" option.

### Releasing

We use GitHub pages when publishing the Swedish eID Framework specifications in HTML format. The script `release.sh` may be used for this purpose. It transforms all specifications into HTML and creates a template `index.html` file with links to all specifications. This index file should later be manually edited so that items such as "changes since last version" and a description of the release are added.

    usage: release.sh <input directory> <output directory>
      Where <input directory> is the directory containing the specifications
  
The output directory could be any directory, but for publishing to GitHub pages you could point it to the directory where you checked out the `gh-pages` branch of the repo. Remember to add a sub-directory since the root of the GitHub pages should only contain an `index.html` file pointing to all releases made. The sub-directory should follow the naming convention `<month>-<year>`. If it is a draft release, the directory should be named `<draft>-<month>-<year>`.

As a part of a release all specifications should be printed to PDF-files. Use the same file names as for the HTML files but a pdf-extension. Place the PDF files in the `pdf` sub-directory (the release script will create this directory).

Finally, zip all PDF files into a file named `swe-eid-specifications.zip` and place it in the `pdf` sub-directory.



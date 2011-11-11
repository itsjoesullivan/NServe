NServe is a nodejs-powered static file server that is created to facilitate local software development. It is not designed for production use. 

![Terminal Screenshot](https://github.com/marty-wang/NServe/raw/master/screenshots/terminal.png)

# Features

* Easy and Fast. One command and serve away.
* Allow user-defined transfer rate to mimck the real situations.
* Delay cross-domain mock web services, including GET and POST.
* Live reload HTML/CSS/JS files. No need to manually refersh browsers.
* More to come...

# Installation

        npm install nserve -g

or install the development version from source code

        npm install {source code folder} -g

# Usage

In the folder where you want to serve the files. Run the command below. 

**nserve** [options]

Options:
        
        -h, --help                                  output usage information
        -V, --version                               output the version number
        -p, --port <n>                              specify the port number [3000]
        -r, --rate <bit rate>                       specify the file transfer rate in Bps, e.g. 100K or 5M
        -v, --verbose                               enter verbose mode
        -d, --directory <root>                      specify the root directory, relative or absolute [current directory]
        -w, --webservice-folder <folder name>       specify the web service folder name ["ws"]
        -D, --webservice-delay <n>                  specify the delay of the web service in millisecond [0]
        -l, --live-reload                           automatically reload HTML/CSS/JS files

and open [http://localhost:3000](http://localhost:3000) in your browser.

#Tips

* **How to use cross-domain mock web services?**

    In the command line you have the option to specify the folder name where all the web services data are stored. In the meantime all the http requests that have the URLs starting with this folder name will be considered as web service calls. For example, by default this folder is named as ***ws***, if you have a file called data.json and another called error.json under the same ***ws*** folder, the **GET** request of http://localhost:3000/ws/data.json will have data.json returned as the payload for your ajax success callback, and the one of http://localhost:3000/ws/data.json?error=error.json will simulate the error situation and return error.json as payload for your ajax error callback. You can name these files howerever you want. You just need to make sure that the pairing data file and error file should stay under the same folder and the error file should be specified as the value of key ***error*** in the query.

    In the case of **POST** request, the principle is the same. The only difference is that the data.json file will mean the post result, and the error file should be put into the data body of request, as error=error.json, as opposed to in the query.

    For an example, please reference the [**ajax.html**](https://github.com/marty-wang/NServe/blob/master/samples/ajax.html) in the **samples** folder.

    Again, by default it defaults to ***ws*** folder for all the web services. But you can change to another folder in the command line with the option **-w** or **--webservice-folder**, and refer to that folder under the root where ***nserve*** is running.

    Also you have the ability to "slow down" the web services by using th option **-D** or **--webservice-delay**. You want to do that in the situation where you want to test your loader, for example.

# TODO

* Add unit testing and refactor code

# License (MIT)

Copyright (c) 2011 Mo Wang <<mo.oss.wang@gmail.com>>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
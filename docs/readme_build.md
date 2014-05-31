# Ascii Invoice Parser

## Overview

This application parses ascii invoice numbers files into normal invoice numbers files.

### How to use

The order to use this application you need 2 things:

1. A command line (aka Terminal) with Ruby installed on it.
2. An input ascii invoices text file

Once you have these two things just follow this instructions:

1. Once inside the application's root folder place your input file in the **"input_files"** directory.
2. Open the Terminal and run the following command: `ruby ascii_invoices_parser.rb "your_input_file_name.txt"`
3. If everything went smoothly you should have have your parsed file waiting for you in the **"output_files"** directory. The parsed file name will be the same as the input file name with the word *"parsed"* at the end of it

### Example

I have an input file called **"my_input_file.txt"** which has this content:

	    _  _     _  _  _  _  _  (line 1)
      | _| _||_||_ |_   ||_||_| (line 2)
      ||_  _|  | _||_|  ||_| _| (line 3)
                                (line 4)
        _  _  _  _  _  _     _  (line 5)
    |_||_|| ||_||    |  |  ||_  (line 6)
      | _||_||_||_|  |     | _| (line 7)

I'll place it in the **"input_files"** directory and run the following command

    ruby ascii_invoices_parser.rb "my_input_file.txt"
    
Once the command has finished running I will have a parsed file waiting in the **"output_files"** which will be called **"my_input_file_parsed.txt"**. And it will have this content:

    123456789
    4908?7?15 ILLEGAL

##### Happy parsing :)
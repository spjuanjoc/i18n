# i18n

Internationalization in Linux with libintl & gettext.

- POT: Portable Object Template
- PO: Portable Object
- MO: Machine Object

## Create template

Create a POT for a file

    xgettext -s -o main.pot main.cpp -k_ 

With the keywords (prefixes) _ _n and _d

    xgettext -s -o main.pot main.cpp -k_ -k_n -k_d --package-name=main --package-version=1

## Create a translations file

Create a PO from the POT in es_CO

    msginit -l es_CO.UTF-8 -o main.po -i main.pot

If it was not auto translated fill the translations in msgstr.  
Set the charset to UTF-8

## Create a binary file

Create a MO from the PO

    msgfmt -c -v -o main.mo main.po 

## Review

Check if the program is loading the .MO correctly

    strace -e trace=openat ./libintl_gettext

Use `msgunfmt` for reverse-compiling .mo files

## The code

```shell
mkdir build && cd build
cmake -DCMAKE_MODULE_PATH=$PWD -DCMAKE_BUILD_TYPE=Debug ..
cmake --build .
```

CMake-configure creates de POT template in ./build/locale/es/LC_MESSAGES  
Then, create the .PO file with `msginit`.  
Fill the translations, including the plural forms.  
Then, create the .MO file with `msgfmt`.  

Then run 

    ./build/libintl_gettext 

The messages should be shown in Spanish, one of them with the plural form. 

## Poedit

The application Poedit is used to create and modify PO and MO files from POT
files. Having a POT you can generate a PO and fill the translations. It is
particularly useful when having an already translated PO file, and updating the
POT, then you can update the PO from the POT using Poedit.

---
See:
- [Progmar Marcin Załęczny](https://progmar.net.pl/en/knowledge-base/gettext)
- [tutorialspoint](https://www.tutorialspoint.com/unix_commands/gettext.htm)
- [transifex](https://docs.transifex.com/formats/gettext)

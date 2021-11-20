# i18n

Internationalization

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

See [Progmar Marcin Załęczny](https://progmar.net.pl/en/knowledge-base/gettext)

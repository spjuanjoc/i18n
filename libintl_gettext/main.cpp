#include <fmt/core.h>
#include <libintl.h>

#define _(x)                    gettext(x)
#define _n(singular, plural, n) ngettext(singular, plural, n)
//#define _d(context, msg)        cgettext(context, msg)
#define N_(x)                   x

constexpr auto saved_string = N_("Some global string\n");  // This will be translated later, so we already have to mark it with a macro to get it extracted.
                            // Let's just hope that we never need a plural version for this.

int main()
{
  std::locale::global(std::locale(""));  // Use the current system locale
  bindtextdomain("main", "./locale");
//  bindtextdomain("main", "/usr/share/locale"); // default
  textdomain("main");

  fmt::print("{}\n", _("The first message."));
  fmt::print(_n("We have {} message.", "We have {} messages.", 6), 6);
  fmt::print("\n");

//  const auto open_file_label = _d("file", "open");  // with context
//  const auto open_door_label = _d("door", "open");  // with context

//  fmt::print(open_file_label);
//  fmt::print("\n");
//  fmt::print("{}\n", open_door_label);

  fmt::print(_(saved_string));
  fmt::print("{}\n", _("Anything"));
  fmt::print("{}\n", _("Clear"));
  fmt::print("{}\n", _("Buffalo"));
  fmt::print("{}\n", _("The last message."));
}

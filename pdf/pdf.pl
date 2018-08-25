#!/usr/bin/perl

use Path::Iterator::Rule;
my $rule = Path::Iterator::Rule->new;
$rule->not_name("*draft*");
$rule->name("*.md");

# top level directories to recurse through
my @dirs = (
  "../sukta",
  "../prayoga"
);

foreach my $d (@dirs) {
  my $it = $rule->iter( $d );
  while ( my $file = $it->() ) {
    $length = length($file) - 3 - 3;                  # trim "../" and ".md" from filenames
    $relative_url = substr($file, 3, $length, "");
    ($pdfname = $relative_url) =~ s/\//_/g;         # turn / into _ for a flat .pdf name
    $pdfname .= ".pdf";

    $url = "http://localhost:4000/" . $relative_url . ".html";
    $cmd = "electron-pdf -p A5 $url $pdfname";

    print $cmd . "\n";
    system ($cmd);
  }
}

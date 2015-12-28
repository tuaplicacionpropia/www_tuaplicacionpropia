use strict;
use warnings;
use diagnostics;

use Data::Dumper;

print "IMPORTING LIBS widgets.pl" . "\n";

=pod
sub wInfoBoxLink { my($title,$href) = @_;
  my $result = "";
  my $title2 = "HOLA";
  $result .= <<'TEXT_WINFOBOXLINK';
<div class="info-box bg-aqua">
 <span class="info-box-icon"><i class="ion-ios-chatbubble-outline"></i></span>
 <div class="info-box-content">
  <span class="info-box-text">$title2</span>
  <span class="info-box-number">163,921</span>
  <div class="progress">
   <div class="progress-bar" style="width: 0%"></div>
  </div>
  <span class="progress-description">
   $href
  </span>
 </div>
</div>
TEXT_WINFOBOXLINK
  return $result;
}
=cut
sub wInfoBoxLink { my($link,$page,$idx) = @_;
  my $result = "";

#  my @BG_COLORS = (
#  "red", "yellow", "aqua", "blue", 
#  "light-blue", "green", "navy", 
#  "teal", "olive", "lime", "orange", 
#  "fuchsia", "purple", "maroon", "black");
  my @BG_COLORS = (
  "red", "yellow", "blue", "green");
  my $bgColorsSize = @BG_COLORS;
  my $bgColor = "bg-".$BG_COLORS[$idx % $bgColorsSize];
  
  my $img = "";
  if (defined $link->{'image'} && length($link->{'image'}) > 0) {
  	$img = repeatText("../", $page->{'src_pathlevel'})."images".$page->{'src_fullbasepath'}."/".$link->{'image'};
  }
  my $linkTitle = "";
  if (defined $link->{'title'} && length($link->{'title'}) > 0) {
  	$linkTitle = $link->{'title'};
  }
  my $linkHref = "#";
  if (defined $link->{'href'} && length($link->{'href'}) > 0) {
  	$linkHref = $link->{'href'};
  }
  my $linkDescription = "";
  if (defined $link->{'description'} && length($link->{'description'}) > 0) {
  	$linkDescription = $link->{'description'};
  }
#  my $prefix = "";
  $result .= "<a class=\"a-info-box\" href=\"".$linkHref."\" target=\"_blank\">"."\n";
  $result .= " <div class=\"info-box ".$bgColor."\">"."\n";
  $result .= "  <span class=\"info-box-icon\">"."\n";
#  $result .= "   <i class=\"ion-ios-chatbubble-outline\"></i>"."\n";
  if (length($img) > 0) {
    $result .= "   <img src=\"".$img."\">"."\n";
  }
  $result .= "  </span>"."\n";
  $result .= "  <div class=\"info-box-content\">"."\n";
  
  $result .= "   <span class=\"info-box-href\">"."\n";
  if (length($linkHref) > 0 && $linkHref ne "#") {
    $result .= "".$linkHref."\n";
  }
  $result .= ""."</span>"."\n";
  $result .= "   <span class=\"info-box-number\">"."\n";
  if (length($linkTitle) > 0) {
    $result .= "".$linkTitle."\n";
  }
  $result .= ""."</span>"."\n";
  if (length($linkDescription) > 0) {
    $result .= "   <div class=\"progress\">"."\n";
    $result .= "    <div class=\"progress-bar\" style=\"width: 0%\"></div>"."\n";
    $result .= "   </div>"."\n";
    $result .= "   <span class=\"progress-description\">"."\n";
    $result .= "".$linkDescription."\n";
    $result .= "   </span>"."\n";
  }
  $result .= "  </div>"."\n";
  $result .= " </div>"."\n";
  $result .= "</a>"."\n";

  return $result;
}
$stash->set('wInfoBoxLink', \&wInfoBoxLink);

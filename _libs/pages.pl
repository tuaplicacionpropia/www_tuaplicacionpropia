use strict;
use warnings;
use diagnostics;

use Data::Dumper;

print "IMPORTING LIBS pages.pl" . "\n";

sub getAllPages {
  my @result = ();
  @result = $stash->get('site')->{'pages'};
  @result = @{$result[0]};
  return @result;
}
$stash->set('getAllPages', \&getAllPages);

sub getFirstPosts { my($numLimit) = @_;
  my @result = ();
  if (!(defined $numLimit) || $numLimit > 0) {
    my $pagesCount = 0;
    my @pages = getAllPages();
    my $pagesLength = @pages;
    @pages = sort { (defined $b->{'crtime'} ? $b->{'crtime'} : 'z') cmp (defined $a->{'crtime'} ? $a->{'crtime'} : 'z') } @pages;
    for (my $i = 0; $i < $pagesLength; $i++) {
      my $cPage = $pages[$i];
      if (!($cPage->{'src_basename'} eq "index")) {
        if (!(defined $numLimit) || $pagesCount < $numLimit) {
          push(@result, $cPage);
          $pagesCount += 1;
        }
      }
    }
  }
  return \@result;
}
$stash->set('getFirstPosts', \&getFirstPosts);

#date = 2015-12-23 16:07:30
#pattern = "%A, %B %e, %Y"
sub formatDate { my($date, $pattern) = @_;
  my $result = "";
  use Time::Piece;
  my $t = Time::Piece->strptime($date, "%Y-%m-%d %H:%M:%S");
  $result = $t->strftime($pattern);
#print ">>>>>>>>>>>> FECHA = ".$result."\n";
  return $result;
}
$stash->set('formatDate', \&formatDate);

sub repeatText { my($text, $num) = @_;
  my $result = "";
  $result = "$text"x$num;
  return $result;
}
$stash->set('repeatText', \&repeatText);

sub getPathPage { my($page) = @_;
  my $result = "";
  $result = $page->{'dirname'};
  my $idx = index($result, '/');
  $result = substr($result, $idx);
  my $length = length($result);
  my $lastChar = substr($result, $length - 1);
  if ($lastChar eq '/' && $length > 1) {
    $result = substr($result, 0, $length - 1);
  }
  return $result;
}
$stash->set('getPathPage', \&getPathPage);

sub loadInnerPages { my($parent) = @_;
  my @result = ();
  my $result2 = "";
  if ($parent->{'src_basename'} eq "index") {
    my $parentPath = $parent->{'src_path'};#getPathPage($parent);
    my $nextPathLevel = $parent->{'src_pathlevel'} + 1;
    my @pages = getAllPages();
    my $pagesLength = @pages;
    $result2 = $pagesLength;
    for (my $i = 0; $i < $pagesLength; $i++) {
      my $cPage = $pages[$i];
      my $cPagePath = $cPage->{'src_path'};#getPathPage($cPage);
#print ">>>>>>>>>>>>> cPagePath = ".$cPagePath." parentPath = ".$parentPath."\n";
      if (index($cPagePath, $parentPath) == 0 && ($parent->{'src_fullpath'} ne $cPage->{'src_fullpath'})) {
        my $subPath = substr($cPage->{'src_path'}, length($parentPath));
#print ">>>>>>>>>>>>> cPagePath = ".$cPagePath." parentPath = ".$parentPath." subPath = ".$subPath."\n";
        if (index($subPath, '/') < 0 || ($cPage->{'src_basename'} eq "index" && $cPage->{'src_pathlevel'} == $nextPathLevel)) {
          push(@result, $cPage);
          $result2 = $result2.",".$cPagePath;
        }
      }
    }
  }

  @result = sort { (defined $a->{'crtime'} ? $a->{'crtime'} : 'z') cmp (defined $b->{'crtime'} ? $b->{'crtime'} : 'z') } @result;

  return \@result;
}
$stash->set('loadInnerPages', \&loadInnerPages);

sub hasMenus { my($parent) = @_;
  my $result = 0;
  my @pages = loadInnerPages($parent);
  my $pagesLength = @pages;
  for (my $i = 0; $i < $pagesLength; $i++) {
    my $cPage = $pages[$i];
    if ($cPage->{'src_basename'} eq "index") {
      $result = 1;
      last;
    }
  }
  return $result;
}
$stash->set('hasMenus', \&hasMenus);

=pod
print Dumper($variable);
=cut

sub getRootPage {
  my %result = ();
  my @pages = getAllPages();
  my $pagesLength = @pages;
  for (my $i = 0; $i < $pagesLength; $i++) {
    my $cPage = $pages[$i];
    my $cPagePath = $cPage->{'src_fullbasepath'};#getPathPage($cPage);
    if ($cPagePath eq "/index") {
      for my $hKey ( keys %$cPage ) {
        my $hValue = $cPage->{$hKey};
     	$result{$hKey} = $hValue;
      }
      last;
    }
  }
  return \%result;
}
$stash->set('getRootPage', \&getRootPage);


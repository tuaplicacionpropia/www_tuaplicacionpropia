print "IMPORTING LIBS functions.pl" . "\n";

sub save { my($key, $value) = @_;
	$stash->set($key, $value);
}

sub load { my($key) = @_;
	return $stash->get($key);
}

sub _varType { my($var) = @_;
  my $result = "";
  if(not ref($var)) {
    $result = "string";
  }
  elsif(ref($var) eq "HASH") {
    $result = "HASH";
  }
  elsif(ref($var) eq "ARRAY") {
    $result = "ARRAY";
  }
  elsif(ref($var) eq "SCALAR") {
    $result = "SCALAR";
  }
  elsif(ref($var) eq "CODE") {
    $result = "CODE";
  }
  elsif(ref($var) eq "REF") {
    $result = "REF";
  }
  elsif(ref($var) eq "VSTRING") {
    $result = "VSTRING";
  }
  elsif(ref($var) eq "Regexp") {
    $result = "Regexp";
  }
  elsif(ref($var) eq "GLOB") {
    $result = "GLOB";
  }
  elsif(ref($var) eq "LVALUE") {
    $result = "LVALUE";
  }
  elsif(ref($var) eq "FORMAT") {
    $result = "FORMAT";
  }
  elsif(ref($var) eq "IO") {
    $result = "IO";
  }
  return $result;
}

$stash->set('save', \&save);
$stash->set('load', \&load);
$stash->set('_varType', \&_varType);

#Add new custom functions here


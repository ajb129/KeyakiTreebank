#!/usr/bin/env perl

use encoding 'euc-jp', STDIN => 'shift_jis';

$ad{"01"} = "£±ÌÌ";
$ad{"02"} = "£²ÌÌ";
$ad{"03"} = "£³ÌÌ";
$ad{"04"} = "²òÀâ";
$ad{"05"} = "¼ÒÀâ";
$ad{"07"} = "¹ñºÝ";
$ad{"08"} = "·ÐºÑ";
$ad{"10"} = "ÆÃ½¸";
$ad{"12"} = "Áí¹ç";
$ad{"13"} = "²ÈÄí";
$ad{"14"} = "Ê¸²½";
$ad{"15"} = "ÆÉ½ñ";
$ad{"16"} = "²Ê³Ø";
$ad{"18"} = "·ÝÇ½";
$ad{"35"} = "¥¹¥Ý¡¼¥Ä";
$ad{"41"} = "¼Ò²ñ";

sub zen2han($) {
    $_[0] =~ tr/¡¡¡ª¡É¡ô¡ð¡ó¡õ¡Ç¡Ê¡Ë¡ö¡Ü¡¤¡Ý¡¥¡¿£°-£¹¡§¡¨¡ã¡á¡ä¡©¡÷£Á-£Ú¡Î¡ï¡Ï¡°¡½¡¡£á-£ú¡Ð¡Ã¡Ñ¡±¡¡/ !-~/;
    $_[0];
}

sub transfer($$) {
    my ( $key, $context ) = @_;
    my $data;

    if ( $key eq 'ID' || $key eq 'C0' || $key eq 'AF' ) {
	$data = zen2han( $context );
    } elsif ( $key eq 'AE' ) {
	$data  = ( $context eq '£Ù' ) ? 'Í­' : 'Ìµ' ;
    } elsif ( $key eq 'S1' ) {
	my $size;
	( $size ) = /.*¡ÊÁ´(.*)Ê¸»ú¡Ë/;
	$data = zen2han( $size );
    } elsif ( $key eq 'AD' ) {
	$data = $ad{zen2han($context)}
    } else {
	$data = $context;
    }

    $data;
}

sub output {
    my $key;

    print "<ENTRY>\n";

    foreach $key ( 'ID', 'C0', 'AD', 'AE', 'AF', 'T1', 'S1' ) {
	print "<", $key, ">", $keyword{$key}->[0], "</", $key, ">\n";
    }
    foreach $key ( 'S2', 'T2' ) {
	print "<",$key,">\n", join("\n",@{$keyword{$key}}), "\n</",$key,">\n";
    }
    foreach $key ( 'KA','AA','KB','AB' ) {
	print "<",$key,">", join( " ",@{$keyword{$key}} ), "</", $key,">\n";
    }
    print "</ENTRY>\n";
}

$first = 1;

while (<STDIN>) {
    chomp;
    ( $tag, $context ) = /¡À(.*)¡À(.*)/;
    $key = zen2han( $tag );
    $data = transfer( $key, $context );
    if ( $key eq "ID" ) {
	if ( $first == 1 ) {
	    $first = 0;
	} elsif ( $first == 0 ) {
	    output;
	    undef %keyword;
	    $first = -1;
	} else {
	    print "\n";
	    output;
	    undef %keyword;
	}
    }
    $keyword{$key} = [] unless $keyword{$key};
    push @{$keyword{$key}}, $data;
}

output;

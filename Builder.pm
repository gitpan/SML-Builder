### //////////////////////////////////////////////////////////////////////////
#
#	TOP
#

=head1 NAME

SML::Builder - Content::Builder using SIMPLIFIED MARKUP LANGUAGE

=cut

#------------------------------------------------------
# 2004/05/13 12:03 - $Date: 2004/05/19 19:49:28 $
# (C) Daniel Peder & Infoset s.r.o., all rights reserved
# http://www.infoset.com, Daniel.Peder@infoset.com
#------------------------------------------------------

###																###
###	this document is edited with tabs having only 4 chars width ###
###																###

### //////////////////////////////////////////////////////////////////////////
#
#	SECTION: package
#

	package SML::Builder;


### //////////////////////////////////////////////////////////////////////////
#
#	SECTION: version
#

	use vars qw( $VERSION $VERSION_LABEL $REVISION $REVISION_DATETIME $REVISION_LABEL $PROG_LABEL );

	$VERSION           = '0.10';
	
	$REVISION          = (qw$Revision: 1.1 $)[1];
	$REVISION_DATETIME = join(' ',(qw$Date: 2004/05/19 19:49:28 $)[1,2]);
	$REVISION_LABEL    = '$Id: Builder.pm_rev 1.1 2004/05/19 19:49:28 root Exp root $';
	$VERSION_LABEL     = "$VERSION (rev. $REVISION $REVISION_DATETIME)";
	$PROG_LABEL        = __PACKAGE__." - ver. $VERSION_LABEL";

=pod

 $Revision: 1.1 $
 $Date: 2004/05/19 19:49:28 $

=cut


### //////////////////////////////////////////////////////////////////////////
#
#	SECTION: debug
#

	use vars qw( $DEBUG ); $DEBUG=0;
	

### //////////////////////////////////////////////////////////////////////////
#
#	SECTION: constants
#

	# use constant	name		=> 'value';
	

### //////////////////////////////////////////////////////////////////////////
#
#	SECTION: modules use
#

	require 5.005_62;

	use strict                  ;
	use warnings                ;
	

### //////////////////////////////////////////////////////////////////////////
#
#	SECTION: methods
#

=head1 METHODS

=over 4

=cut



### ##########################################################################

=item	new

 $sml = SML::Builder->new();
 
=cut

### --------------------------------------------------------------------------
sub		new
### --------------------------------------------------------------------------
{
	my( $proto ) = @_;
	bless {}, ref( $proto ) || $proto;
}


### ##########################################################################

=item	build ( [ \@items ] )

Build back the sml text from parsed sml items.

=cut

### --------------------------------------------------------------------------
sub		build
### --------------------------------------------------------------------------
{
	my( $self, $items )=@_;

		$items	||= $self->{sml};
		
	my	$result	= '';
	for	my $item ( @$items )
	{
		$result .= $self->build_item( $item );
	}
	$result
}


### ##########################################################################

=item	build_item ( $item )

Build single item.

=cut

### --------------------------------------------------------------------------
sub		build_item
### --------------------------------------------------------------------------
{
	my( $self, $item )=@_;

	my	$type	= $item->[0];
	my( $pi, $name, $attrs_unparsed )	;
	my	$body							;
	my	$content						= '';
	my	$result							= '';
	
	if( $type eq 'E' )
	{
		( $pi, $name, $attrs_unparsed )	= @$item[1,2,3];
	}
	else	#  'C', 'T'
	{
		$body							= $item->[1];
	}
	
	if(		$type eq 'E' )	# restore element
	{
		$result	= join( '', '<', $pi, $name, $attrs_unparsed, '>' );
	}
	elsif(	$type eq 'C' )	# restore comment
	{
		$result	= join( '', '<!--', $body, '-->' );
	}
	elsif(	$type eq 'T' )	# restore text
	{
		$result	= $body;
	}
	else
	{
		$result	= join( ' ', @$item );
	}
	
	$result
}


=back

=cut


1;

__DATA__

__END__

### //////////////////////////////////////////////////////////////////////////
#
#	SECTION: TODO
#

=head1 TODO	


=cut

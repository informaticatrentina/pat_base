{def $forumsRssUrl='http://www.provincia.tn.it/feed_rss.php?tab=feed_rss&id_feed=1'}
    <h2>
	  <a href='http://www.provincia.tn.it/feed_rss.php?tab=feed_rss&id_feed=1'>
	  <img width="16px" height="16px" src={"rss-icon.gif"|ezimage} />
	  RSS Sezione Prima pagina <small>Provincia autonoma di Trento</small>
	  </a>
	</h2>    
<div class="community-activity">
    <div class="loading">
        Loading the latest forum posts...
        <img src={'2/loader.gif'|ezimage} />
    </div>
    <div id="feed-elements">


    </div>
</div>

<script type="text/javascript">
    {literal}
    // Fetch the latest forum posts from share.ez.no
            $(document).ready(
            $.ajax({
        url: document.location.protocol + '//ajax.googleapis.com/ajax/services/feed/load?v=1.0&num={/literal}{$block.number_of_items}{literal}&callback=?&q=' + encodeURIComponent( '{/literal}{$forumsRssUrl}{literal}' ),
        dataType: 'json',
        success: function( data )
        {
            // Hide the loading wheel
            $( '.community-activity .loading' ).addClass( 'hide' );

            // Build the markup to show the latest posts
            var html = '<ul>';

            $( data.responseData.feed.entries ).each( function()
            {
                var $item = $(this);
                var $date = new Date( $item.attr("publishedDate") );

                //trace( $item.attr("link") );
                html += '<li>' +
                        '<h5><a href ="' + $item.attr( "link" ) + '?utm_content=eZ+Publish+Community+Project+{/literal}{$versionString}{literal}&utm_source=eZ+Publish+Community+Project+Dashboard&utm_medium=eZ+Publish+Community+Project+Dashboard&utm_campaign=eZ+Publish+Community+Project+Dashboard' + '">' + $item.attr( "title" ) + '</a></h5> ' +
                        '<p>' + $item.attr("author") + ' - <em>' + $date.getDate() + '/' + $date.getMonth() + '/' + $date.getFullYear() + ' ' + $date.getHours() + ':' + $date.getMinutes() + '</em></p>' +
                    // '<p>' + $item.attr("c:date") + '</p>' +
                        '</li>';
            });

            html += '</ul>';

            // Show the results
            $( 'div.community-activity #feed-elements' ).append( html );
        }
    })
    );


    {/literal}
</script>

<script>{literal}
$(document).ready(function() {
  var touch = false;
  if (window.Modernizr) {
    touch = Modernizr.touch;
  }
  if (!touch) {
    $("body").on("mouseenter", ".has-tooltip", function() {
      var el;
      el = $(this);
      if (el.data("tooltip") === undefined) {
        el.tooltip({
          placement: el.data("placement") || "top",
          container: el.data("container") || "body"
        });
      }
      return el.tooltip("show");
    });
    $("body").on("mouseleave", ".has-tooltip", function() {
      return $(this).tooltip("hide");
    });
  }
});
{/literal}</script>

<div class="content-view-full">
  <div class="content-title">
	  <h1>Per rimanere aggiornato</h1>
  </div>

  <div class="content-main wide">
	
  {def $rssexport_list = rss_list( 'export' )}
  <h3>Feed RSS</h3>
  <table class="table table-striped" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <th>Contenuti</th>
      <th class="text-center">Link RSS</th>
    </tr>
		{foreach $rssexport_list as $item)}
    <tr>
        <td>{$item.title|wash}</td>
        <td class="text-center"><a href={concat("feed/rss/",$item.access_url)|ezurl}class="btn btn-warning btn-md"><i class="fa fa-rss"></i></a></td>
    </tr>
    {/section}
  </table>

  </div>
</div>
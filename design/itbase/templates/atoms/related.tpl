{set_defaults(hash(
  'modulo', 3,
  'col-width', 4,
  'limit', 3
))}
{if $item|has_attribute( 'argomento' )}
  
  {def $__argomenti = $item|attribute( 'argomento' )}
  {def $tag_filter = array()}
  {def $class_filter = array()}

  {if count( $__argomenti.content.tags )|gt(1)}
    {set $tag_filter = array( 'or' )}
  {/if}
  {foreach $__argomenti.content.tags as $tag}
    {set $tag_filter = $tag_filter|append( concat( 'attr_argomento_lk:"', $tag.keyword, '"' ) )}
  {/foreach}

  {set $class_filter = 'meta_class_identifier_ms: comunicato' }
  {def $result_comunicato = fetch( ezfind, search, hash( 'filter', array( concat( '-meta_id_si:', $item.contentobject_id ), $tag_filter, $class_filter ), 'offset', $view_parameters.offset, 'limit', $limit, sort_by, hash( 'published', 'desc' ) ))}

  {set $class_filter = 'meta_class_identifier_ms: article' }
  {def $result_article = fetch( ezfind, search, hash( 'filter', array( concat( '-meta_id_si:', $item.contentobject_id ), $tag_filter, $class_filter ), 'offset', $view_parameters.offset, 'limit', $limit, sort_by, hash( 'published', 'desc' ) ))}

  {set $class_filter = 'meta_class_identifier_ms: video' }
  {def $result_video = fetch( ezfind, search, hash( 'filter', array( concat( '-meta_id_si:', $item.contentobject_id ), $tag_filter, $class_filter ), 'offset', $view_parameters.offset, 'limit', $limit, sort_by, hash( 'published', 'desc' ) ))}

  {set $class_filter = 'meta_class_identifier_ms: audio' }
  {def $result_audio = fetch( ezfind, search, hash( 'filter', array( concat( '-meta_id_si:', $item.contentobject_id ), $tag_filter, $class_filter ), 'offset', $view_parameters.offset, 'limit', $limit, sort_by, hash( 'published', 'desc' ) ))}

  {if or($result_comunicato.SearchCount|gt(0), $result_article.SearchCount|gt(0), $result_video.SearchCount|gt(0), $result_audio.SearchCount|gt(0) )}
  <hr />
  <div class="row">
    <div class="col-xs-12">        
      <h2><i class="fa fa-cloud"></i> Potrebbe interessarti</h2>
    </div>
  </div>

	<div class="row">
  <section class="portfolio_masonry_container isotope panels-container">
      {foreach $result_comunicato.SearchResult as $child }
          <div class="t_xs_align_c isotope-item col-md-4">
              {node_view_gui content_node=$child view=panel image_class=widemedium}
          </div>
      {/foreach}

      {foreach $result_article.SearchResult as $child }
          <div class="t_xs_align_c isotope-item col-md-4">
              {node_view_gui content_node=$child view=panel image_class=widemedium}
          </div>
      {/foreach}

      {foreach $result_video.SearchResult as $child }
          <div class="t_xs_align_c isotope-item col-md-4">
              {node_view_gui content_node=$child view=panel image_class=widemedium}
          </div>
      {/foreach}

      {foreach $result_audio.SearchResult as $child }
          <div class="t_xs_align_c isotope-item col-md-4">
              {node_view_gui content_node=$child view=panel image_class=widemedium}
          </div>
      {/foreach}



  </section>
  </div>
  
{/if}

{ezscript_require( array( 'ezjsc::jquery', 'jquery.isotope.min.js' ) )}
{literal}
<script>
$('.portfolio_masonry_container').isotope({
  itemSelector : '.isotope-item',
  layoutMode : 'masonry',
  masonry: {
    columnWidth: 10,
    gutter:0
  }
});
</script>
{/literal}
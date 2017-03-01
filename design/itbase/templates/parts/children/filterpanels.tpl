{set_defaults(hash(
  'page_limit', 10
))}

{def $root_nodes = array( $node.node_id )
    $self = object_handler( $node )}
{if is_set( $self.content_virtual.folder.subtree )}
 {set $root_nodes = $self.content_virtual.folder.subtree}
{/if}

{def $data = class_search_result(  hash( 'subtree_array', $root_nodes,
                    'sort_by', hash( 'published', 'desc' ),
                    'limit', $page_limit ),
                  $view_parameters )}
           
<div class="row">
    <div class="col-md-8">
     {if and( $data.is_search_request, is_set( $view_parameters.class_id ) )}

       <h2>{"SearchResult"|i18n('design/pat_base/generic')}</h2>
       <p class="navigation">
         {foreach $data.fields as $field}
         <a class="btn btn-xs btn-info" href={concat( $node.url_alias, $field.remove_view_parameters )|ezurl()}>
         <i class="fa fa-close"></i> <strong>{$field.name}:</strong> {$field.value}
         </a>
         {/foreach}
         <a class="btn btn-xs btn-danger" href={$node.url_alias|ezurl()}>{"CancelSearch"|i18n('design/pat_base/generic')} </a>
       </p>

       {if $data.count}	  
            <div class="content-view-children">
                <div class="row panels-container">
           
           {foreach $data.contents as $child }
              <div class="col-md-6" id="content-related-folder">
               {node_view_gui content_node=$child view=panel image_class=widemedium}
              </div>
                {delimiter modulo=$modulo}</div><div class="row panels-container">{/delimiter}
                {/foreach}
                </div>
            </div>

         {include name=navigator
                 uri='design:navigator/google.tpl'
                 page_uri=$node.url_alias
                 item_count=$data.count
                 view_parameters=$view_parameters
                 item_limit=$page_limit}
            {* Inclusione del js masonry per togliere gli spazi tra i div*}
            {*literal}
                <script>
                   $('.content-view-children').masonry({
                       // options
                       itemSelector: '#content-related-folder'
                   });
               </script> 
            {/literal*} 
       {else}
         <div class="warning">{"NoResult"|i18n('design/pat_base/generic')}</div>
       {/if}	
     {else}

      {include uri='design:parts/children/panels.tpl'}

     {/if}
     </div>

    <div class="col-md-4">
        {include uri='design:parts/searchform.tpl'}
    </div>
</div>

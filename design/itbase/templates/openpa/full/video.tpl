{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{*if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if*}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )}

<div class="content-view-full class-{$node.class_identifier} row">

    {if or( $node|has_attribute( 'numero' ), $node|has_attribute( 'argomento' ) )}
        <p class="pull-right">
            {if $node|has_attribute( 'numero' )}
                <span class="date label label-info">Comunicato {attribute_view_gui attribute=$node|attribute( 'numero' )}  </span>
            {/if}
            {if $node|has_attribute( 'argomento' )}
                <span style="margin-left: 10px;">{attribute_view_gui attribute=$node|attribute( 'argomento' )}</span>
            {/if}
        </p>
    {/if}

    <div class="content-title">
      <h1>{$node.name|wash()}</h1>
    </div>

    {if $show_left}
      {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    {def $parent_node=fetch( 'content', 'node', hash( 'node_id', $node.parent_node_id))}
    
    {if $parent_node.object.class_identifier|eq('youtube_playlist')}
        {* PLAYLIST *}
        <div class="content-main">
          {if $node.object.data_map.video_url.has_content}
            <div class="video-wrapper">
              {$node.data_map.video_url.content|autoembed(array( '<div class="video-container">', '</div>' ), hash( 'width', '600' ) )}
            </div>
          {/if}
        </div>

        <div class="content-related">
            {include uri='design:parts/social_buttons.tpl'}

            {if $parent_node.children_count|gt(0)}
                <h2><i class="fa fa-youtube-play"></i> Playlist</h2>
                <p>{$parent_node.children_count} video in questa playlist</p>
            {/if}

            {if $parent_node.children_count|gt(0)}
                <div class="clearfix">

                    {foreach $parent_node.children as $child}
                        <a href="{if is_set( $child.url_alias )}{$child.url_alias|ezurl('no')}{else}#{/if}" class="pull-left" style="margin-right: 1px; margin-bottom: 1px;">
                            {attribute_view_gui attribute=$child.object.data_map.image image_class="squaremini"}
                        </a>
                    {/foreach}
                </div>
            {/if}

            <hr/>

            {if $node.data_map.abstract.has_content}
                <div class="attribute-short float-break">
                    {attribute_view_gui attribute=$node.data_map.abstract}
                </div>
            {/if}

        </div>
    {else}
        {* VIDEO SINGOLO *}
        <div class="content-main">
          {if $node.object.data_map.video_url.has_content}
            <div class="video-wrapper">
              {$node.data_map.video_url.content|autoembed(array( '<div class="video-container">', '</div>' ), hash( 'width', '600' ) )}
            </div>
          {/if}
        </div>

        <div class="content-related">
            {include uri='design:parts/social_buttons.tpl'}

            {if $node.data_map.abstract.has_content}
                <div class="attribute-short float-break">
                    {attribute_view_gui attribute=$node.data_map.abstract}
                </div>
            {/if}

        </div>
    {/if}

</div>

{include uri='design:atoms/related.tpl' item=$node}
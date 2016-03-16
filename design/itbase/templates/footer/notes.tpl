<h3>
    {def $root_node_id = ezini( 'NodeSettings', 'RootNode', 'content.ini' )}
    {def $root_node = fetch( 'content', 'node', hash( 'node_id', $root_node_id ) )}
    
    {$root_node.name|wash()}
</h3>
    
<p>
    {def $footer_notes = footer('footer_notes')}
    
    {attribute_view_gui attribute=$footer_notes}
</p>

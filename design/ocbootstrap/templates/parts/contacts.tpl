<ul class="list-unstyled vertical_list">
{if is_set($data.telefono)}
  <li><a href="tel:{$data.telefono}"><i class="fa fa-phone-square"></i> {$data.telefono}</a></li>
{/if}
{if is_set($data.fax)}
  <li><a href="tel:{$data.fax}"><i class="fa fa-fax"></i> {$data.fax}</a></li>
{/if}
{if is_set($data.email)}
  <li><a href="mailto:{$data.email}"><i class="fa fa-envelope-o"></i> {$data.email} </a></li>
{/if}
{if is_set($data.pec)}
  <li><a href="mailto:{$data.pec}"><i class="fa fa-envelope"></i> {$data.pec}</a></li>
{/if}
{if is_set($data.indirizzo)}
  <li><a href="http://maps.google.com/maps?q={$data.indirizzo|urlencode}"><i class="fa fa-building"></i> {$data.indirizzo}</a></li>
{/if}		
</ul>
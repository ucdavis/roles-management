Tuesday, July 29, 2014
======================
 * Added a comparator to DssRm.Applications collection so application cards
   always appear in ABC order
 * Use roles/show.json.jbuilder in RolesController#update. Fixes a bug where
   making a role assignment would result in inactive entities appearing in the
   sidebar where previously they had not.
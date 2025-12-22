/*
 *		Event delayer for LegenDoom
 *		Waits a few tics to led LD do its initialization,
 *		then adds champion status is the monster is legendary
 *		
 *		created by worldendDominator with edits by Untitled.
 */

class champion_LDoomDelayer : thinker {
   actor holder;
   class<thinker> champColor;
   int controllerID;
   
   bool colours;
   bool icons;
   bool particles;
   bool bundles;
   
   bool given; //This is new.
   
   double icon_scale;
   double icon_alpha;

   int mutationchance;
   int mutation;
   
   bool ld_dormant;
   bool ld_boost;
   bool ld_additive;
   
   override void Tick() {
      super.Tick();
      
      if (level.time >= 3) {
         string ldtoken = "LDLegendaryMonsterToken";
         if (holder &&  holder.CountInv(ldtoken)) {
            holder.A_GiveInventory("champion_PersistentInfo");
            let info = champion_PersistentInfo(holder.FindInventory("champion_PersistentInfo"));
            
            if (info) {
               info.c = champColor;
               info.i = controllerID;
            }
            
            let controller = champion_BaseController(new(champColor));
            if (controller && !given) { //So it can't activate if already given.
               controller.champion         = holder;
               
               controller.colours         = colours;
               controller.icons         = icons;
               controller.particles      = particles;
               controller.bundles         = bundles;
               controller.mutationchance   = mutationchance;
               controller.mutation         = mutation;
               controller.legend         = true;
               controller.ld_dormant      = ld_dormant;
               controller.ld_boost         = ld_boost;
               
               controller.icon_scale      = icon_scale;
               controller.icon_alpha      = icon_alpha;
               
               given = true; //Set to given to make sure the base controller is only instantiated once!
            }
         }
      if(ld_additive)
         return;
         
         self.Destroy();
         return;
      }
   }
}


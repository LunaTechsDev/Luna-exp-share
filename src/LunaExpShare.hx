import core.Types.JsFn;
import rm.objects.Game_Actor;
import rm.Globals;
import rm.managers.PluginManager;
import utils.Fn;
import utils.Comment;

class LunaExpShare {
 public static function main() {
  final params = Globals.Plugins.filter((plugin) -> {
   return ~/<LunaExpShare>/ig.match(plugin.description);
  })[0].parameters;

  final ExpShareParam = Fn.parseFloatJs(params["ReserveExp"]);

  Comment.title("Game_Actor");
  var oldBenchExpRate: JsFn = Fn.getPrProp(Game_Actor, "benchMembersExpRate");
  Fn.setPrProp(Game_Actor, "benchMembersExpRate", () -> {
   return
    Globals.DataSystem.optExtraExp ? percentToFloat(ExpShareParam) : oldBenchExpRate.call(Fn.self);
  });
 }

 public static inline function percentToFloat(percent: Float) {
  return percent / 100.0;
 }
}

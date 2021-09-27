local trk  = {}
  trk.tls, trk.obj, trk.item, trk.lookup = {}, {}, {}, {}
  -- t.sandw = { 300, 301, 302, 326, 350, 349, 348, 324 }
  -- t.swater= { 303, 304, 305, 329, 353, 352, 351, 327 }
  -- t.sawa  = { 372, 373, 374, 398, 422, 421, 420, 396 }

  trk.tls.water = 397 
  trk.tls.sand  = 275
  trk.tls.thick = 299
  trk.tls.thin  = 276

  trk.obj.roca = 0 trk.obj.rocb = 1 trk.obj.rocc = 2 trk.obj.rocd = 3
  trk.obj.roka = 4 trk.obj.rokb = 5 trk.obj.rokc = 6 trk.obj.rokd = 7
  trk.obj.shruba, trk.obj.shrubb, trk.obj.shrubc  = 24, 25, 26

  local function itemprofile( nm, t, f, o, c, e, a, n )
    trk.item[nm] = t
    trk.lookup[t] = { name=nm, food=f, openn=o, consc=c, extro=e, agree=a, neuro=n }
  end
  itemprofile('knife',      36, false, 60, 60, 60, 40, 32)
  itemprofile('matches',    37, false, 66, 55, 50, 40, 32)
  itemprofile('silverBar',  60, false, 50, 50, 50, 50, 60)
  itemprofile('silverCoin', 61, false, 50, 50, 50, 50, 60)
  itemprofile('goldBar',    84, false, 50, 50, 50, 50, 70)
  itemprofile('goldCoin',   85, false, 50, 50, 50, 50, 80)

  itemprofile('watermelon', 38, 1, 50, 50, 50, 50, 50)
  itemprofile('sushi',      39, 1, 50, 50, 50, 50, 50)


  print("---", trk.item['watermelon'])

return trk

/* 
window = 
  0 -> meniu
  1 -> alege adversar
  2 -> PvP
  3 -> PvC
  4 -> tutorial
  5 -> setari
  6 -> personalizare
  7 -> Joc PvP normal
  8 -> Joc PvP special
  9 -> Joc PvC

arrow = 
  W3 -> 0, 1
  W5 -> 2 ... 9
  W6 ->10 ... 17

button = 
  0 -> menu
  1 -> play
  2 -> tutorial
  3 -> settings
  4 -> customize
  5 -> exit
  6 -> PvP
  7 -> PvC
  8 -> PvP Normal
  9 -> PvP Special
  10-> PvC Easy
  11-> PvC Hard
  12-> PvC Custom
  13-> Back
  14-> Next
  15-> Apply
  16-> Skip Move
  17-> Play Again
  18-> No
  19-> Yes
  
*/


/*
        searchSafeZone(-1);
        searchKillerZone(0);
        if(lungK > 0)
        {
          int x1 = -1, y1 = -1;
          int aux;
          aux = (int)random(lungK);
          var1 = vectKiller[aux][0];
          var2 = vectKiller[aux][1];
          if(lungS > 0) 
          {
            aux = (int)random(lungS);
            x1 = vectSafe[aux][0];
            y1 = vectSafe[aux][1];
            board[x1][y1] = -2;
          }
          else
          {
            searchKillerZone(-1);
            if(lungK > 0)
            {
              aux = (int)random(lungK);
              x1 = vectKiller[aux][0];
              y1 = vectKiller[aux][1];
              searchKillerZone(0);
            }
          }
          if(lungK > 0)
          {
            board[x1][y1] = 0;
            turn = 1;
            boolean gasit_ = false;
            for(i = 0; i < lungK && !gasit_; ++i)
            {
               board[vectKiller[i][0]][vectKiller[i][1]] = -1;
               if(gameOver())
                 gasit_ = true;
               board[vectKiller[i][0]][vectKiller[i][1]] = 0;
            }
            turn = 2;
            if(gasit_)
            {
              var1 = vectKiller[i - 1][0];
              var2 = vectKiller[i - 1][1];
            }
            board[x1][y1] = -2;
          }
          else
            var1 = var2 = -1;
        }
      */

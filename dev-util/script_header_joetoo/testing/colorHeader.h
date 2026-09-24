// Copyright 2014-2026 Joseph Brendler
// SPDX-License-Identifier: GPL-3.0-or-later

/*
 * ensure you include <iostream> and <string>
 */

  //---[ control sequence indicator == hex "0x1b["
//  std::string CSI;
//  CSI.assign<int>(1,0x1b);
//  CSI.append<int>(1,0x5b);
  std::string CSI	("\x1b[");

  //---[ Select Graphics Rendition (SGR) on/off ]--------------------------------
  std::string BOLD      ( "1" );
  std::string ULINE     ( "4" );
  std::string BLINK     ( "5" );
  std::string BLINKFAST ( "6" );
  std::string ULINE_OFF ( "24" );
  std::string BLINK_OFF ( "25" );
  std::string SGR_OFF   ( "0" );

  //---[ colors, foreground ]----------------------------------------------------
  std::string BLACK     ( "30" );
  std::string RED       ( "31" );
  std::string GREEN     ( "32" );
  std::string YELLOW    ( "33" );
  std::string BLUE      ( "34" );
  std::string MAG       ( "35" );
  std::string CYAN      ( "36" );
  std::string WHITE     ( "37" );

  //---[ my favorite colors, terminate with B_OFF ]------------------------------
  std::string BR_ON     ( CSI + RED    + ";" + BOLD + "m"  );
  std::string BG_ON     ( CSI + GREEN  + ";" + BOLD + "m"  );
  std::string BY_ON     ( CSI + YELLOW + ";" + BOLD + "m"  );
  std::string BB_ON     ( CSI + BLUE   + ";" + BOLD + "m"  );
  std::string BM_ON     ( CSI + MAG    + ";" + BOLD + "m"  );
  std::string BC_ON     ( CSI + CYAN   + ";" + BOLD + "m"  );
  std::string BW_ON     ( CSI + WHITE  + ";" + BOLD + "m"  );

  std::string B_OFF     ( CSI + "0m" );

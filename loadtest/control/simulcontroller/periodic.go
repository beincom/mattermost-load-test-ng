// Copyright (c) 2019-present Mattermost, Inc. All Rights Reserved.
// See License.txt for license information.

package simulcontroller

import (
	"sync"
	"time"
)

const (
	getUsersStatusByIdsInterval = 60 * time.Second
)

func (c *SimulController) periodicActions(wg *sync.WaitGroup, getUsersStatusByIdsInterval float64) {
	defer wg.Done()
	for {
		select {
		case <-time.After(time.Duration(getUsersStatusByIdsInterval) * time.Second):
			if resp := c.getUsersStatuses(); resp.Err != nil {
				c.status <- c.newErrorStatus(resp.Err)
			} else {
				c.status <- c.newInfoStatus(resp.Info)
			}
		// We can add more periodic actions here.
		case <-c.disconnectChan:
			return
		}
	}
}
